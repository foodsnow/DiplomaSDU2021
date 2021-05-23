import 'dart:io';

import 'package:diploma_flutter_app/cubit/home/home_cubit.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateBurnOutPage extends StatefulWidget {
  @override
  createState() => _CreateBurnOutPage();
}

class _CreateBurnOutPage extends State<CreateBurnOutPage> {
  File _documentImage;
  List<int> indexes = [];
  HomeCubit _homeCubit;

  Directory rootPath;
  String filePath;
  String dirPath;
  final bool isDesktop = !(Platform.isAndroid || Platform.isIOS);
  FileTileSelectMode filePickerSelectMode = FileTileSelectMode.checkButton;

  final textPriceController = TextEditingController();
  final textDescController = TextEditingController();

  static const MethodChannel _channel = const MethodChannel('file_picker');
  static const String _tag = 'FilePicker';

  final dateValue = ValueNotifier<String>("Дедлайн");
  final _formKeyPrice = GlobalKey<FormState>();
  final _formKeyDescription = GlobalKey<FormState>();

  List<String> chips = [
    'Backend',
    'Frontend',
    'Designer',
    'PM',
    'DS',
    'IOS',
    'Android',
  ];

  @override
  void initState() {
    _prepareStorage();
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mainText('Создайте горячий проект'),
              sizedHeightBox(32),
              Form(
                key: _formKeyPrice,
                child: customInputTextField(
                  'Цена',
                  price: true,
                  textEditingController: textPriceController,
                ),
              ),
              sizedHeightBox(24),
              Form(
                key: _formKeyDescription,
                child: customInputTextField('Описание',
                    maxLine: 4,
                    text: true,
                    textEditingController: textDescController),
              ),
              sizedHeightBox(24),
              ValueListenableBuilder(
                valueListenable: dateValue,
                builder: (context, value, widget) {
                  return InkWell(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2021, 5, 13),
                          maxTime: DateTime(2025, 6, 7), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        dateValue.value = date.toString().split(" ").first;
                        print('confirm ${date.toString().split(" ").first}');
                      }, currentTime: DateTime.now(), locale: LocaleType.ru);
                    },
                    child: Ink(
                      child: customInputTextField(
                        value,
                        icon: 'assets/icons/down_icon.svg',
                        isEnabled: false,
                      ),
                    ),
                  );
                },
              ),
              getBuilder(),
              sizedHeightBox(24),
              _getRowImageFile(1, 'Загрузите техническое задание'),
              sizedHeightBox(24),
              mainText('Выберите разработчиков'),
              sizedHeightBox(10),
              getWrappedChips(chips, indexes, (index) {
                setState(() {
                  indexes.contains(index)
                      ? indexes.remove(index)
                      : indexes.add(index);
                  print(indexes);
                });
              }),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: customElevatedButton(context, 'Опубликовать',
                      edgeInsets: const EdgeInsets.all(8),
                      width: null, onOk: () {
                    if (!_formKeyPrice.currentState.validate()) return;
                    if (!_formKeyDescription.currentState.validate()) return;
                    if (dateValue.value == "Дедлайн") return;
                    if (indexes.isEmpty) return;
                    List<int> newChipsIndexes =
                        indexes.map((e) => e + 1).toList();
                    if (filePath == null) return;

                    _homeCubit
                      ..createBurnProjects(
                        filePath,
                        textPriceController.value.text,
                        textDescController.value.text,
                        dateValue.value,
                        newChipsIndexes,
                      );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getRowImageFile(int type, String text) {
    return Container(
      constraints: BoxConstraints.expand(width: double.infinity, height: 123),
      padding: EdgeInsets.all(17),
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.PrimaryAssentColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _defaultImages(type, _documentImage),
          sizedWidthBox(6),
          mainText(text, 15),
          sizedHeightBox(1),
          secondaryText('(до 400 MB)', 12),
        ],
      ),
    );
  }

  Widget _defaultImages(int type, File _image) {
    return SizedBox(
      height: 53,
      width: 53,
      child: IconButton(
        icon: _image == null
            ? SvgPicture.asset('assets/icons/document_icon.svg')
            : Image.file(_image),
        onPressed: () {
          if (rootPath != null) {
            _openFile(context);
          }
        },
      ),
    );
  }

  Future<void> _prepareStorage() async {
    rootPath = await getTemporaryDirectory();

    // Create sample directory if not exists
    Directory sampleFolder = Directory('${rootPath.path}/Sample folder');
    if (!sampleFolder.existsSync()) {
      sampleFolder.createSync();
    }

    // Create sample file if not exists
    File sampleFile = File('${sampleFolder.path}/CV.pdf');
    if (!sampleFile.existsSync()) {
      sampleFile.writeAsStringSync('Файл выбран');
    }

    setState(() {});
  }

  Future<void> _openFile(BuildContext context) async {
    String path = await FilesystemPicker.open(
      title: 'Open file',
      context: context,
      rootDirectory: rootPath,
      fsType: FilesystemType.file,
      folderIconColor: Colors.teal,
      allowedExtensions: ['.pdf'],
      fileTileSelectMode: filePickerSelectMode,
      requestPermission: !isDesktop
          ? () async => await Permission.storage.request().isGranted
          : null,
    );

    if (path != null) {
      File file = File('$path');
      String contents = await file.readAsString();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(contents),
        ),
      );
    }

    setState(() {
      filePath = path;
    });
  }

  Widget getBuilder() {
    return BlocConsumer(
        bloc: _homeCubit,
        listener: (context, state) {
          if (state is CreateBurnProjectErrorState) {
            print("Error type +${state.status} + ${state.details}");
            showAlert(context, "Ошибка", state.details, () {});
          }
          if (state is CreateBurnSuccessState) {
            print("Success type +${state.status} + ${state.details}");
            Navigator.of(context).pushNamed('/Home');
          }
        },
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        });
  }
}

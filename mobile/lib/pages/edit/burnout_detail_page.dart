import 'package:diploma_flutter_app/cubit/home/home_cubit.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BurnOurDetailPage extends StatefulWidget {
  final int id;

  const BurnOurDetailPage(this.id);

  @override
  createState() => _BurnOurDetailPage();
}

class _BurnOurDetailPage extends State<BurnOurDetailPage> {
  List<int> indexes = [];
  Future<bool> _isClientState;

  int burnProjectId = 0;

  HomeCubit _homeCubit;

  final _formKeyPrice = GlobalKey<FormState>();
  final textPriceController = TextEditingController();

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
    _isClientState = isDeveloper();
    _homeCubit = BlocProvider.of<HomeCubit>(context)
      ..getBurnProjectById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 34, 10),
        child: SingleChildScrollView(
            child: BlocConsumer<HomeCubit, HomeCubitState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeInitialState || state is HomeLoadingState) {
              return CircularProgressIndicator();
            }
            if (state is BurnProjectSuccessState) {
              burnProjectId = state.burn.id;
              print("BUrn id + ${state.burn.id}");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  mainText(state.burn.title),
                  sizedHeightBox(4),
                  customText(
                    'до ${state.burn.deadline}',
                    10,
                    CustomColors.RedColor,
                    FontWeight.bold,
                  ),
                  sizedHeightBox(8),
                  customText(
                    state.burn.description,
                    14,
                    CustomColors.MainTextColor,
                    FontWeight.normal,
                  ),
                  sizedHeightBox(24),
                  getItemDivider(),
                  sizedHeightBox(12),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/OpenPdfView',
                        arguments: state.burn.fileDoc,
                      );
                    },
                    child: Ink(
                      child: Row(
                        children: [
                          IconButton(
                            icon: SvgPicture.asset('assets/icons/pdf_icon.svg'),
                            onPressed: () {},
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              mainText('ТехЗадание.pdf', 12),
                              customText(
                                '250MB',
                                9,
                                CustomColors.MainTextColor,
                                FontWeight.normal,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  sizedHeightBox(12),
                  getItemDivider(),
                  sizedHeightBox(10),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 14,
                    children: [
                      for (var index = 0; index < chips.length; index++)
                        ChoiceChip(
                          label: mainText(chips[index], 10),
                          backgroundColor:
                              CustomColors.ContainerBackgroundColor,
                          selected: false,
                        ),
                    ],
                  ),
                  FutureBuilder<bool>(
                      future: _isClientState,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.hasData) {
                          return Visibility(
                            visible: snapshot.data,
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 48, 0, 17),
                                child: customElevatedButton(
                                  context,
                                  'Откликнуться',
                                  onOk: () {
                                    getModalSheet();
                                  },
                                  edgeInsets: const EdgeInsets.all(8.0),
                                  width: null,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ],
              );
            }
            if (state is BurnProjectErrorState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<HomeCubit>(context)
                        ..isFetching = true
                        ..getBurnProjectById(widget.id);
                    },
                    icon: Icon(Icons.refresh),
                  ),
                  const SizedBox(height: 15),
                  Text(state.details, textAlign: TextAlign.center),
                ],
              );
            }
            return Container();
          },
        )),
      ),
    );
  }

  void getModalSheet() {
    showMaterialModalBottomSheet(
      expand: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return SingleChildScrollView(
            controller: ModalScrollController.of(context),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 38, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: SvgPicture.asset('assets/icons/close_icon.svg'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  sizedHeightBox(16),
                  mainText('Выберите вашу категория', 17),
                  sizedHeightBox(12),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    children: [
                      for (var index = 0; index < chips.length; index++)
                        ChoiceChip(
                          label: mainText(chips[index], 10),
                          selectedColor: CustomColors.PrimaryColor,
                          backgroundColor:
                              CustomColors.ContainerBackgroundColor,
                          onSelected: (bool selected) {
                            setModalState(() {
                              indexes.clear();
                              indexes.add(index);
                            });
                          },
                          selected: indexes.contains(index),
                        ),
                    ],
                  ),
                  getBuilder(),
                  sizedHeightBox(32),
                  mainText('Ваша цена'),
                  sizedHeightBox(11),
                  Form(
                    key: _formKeyPrice,
                    child: customInputTextField(
                      'Цена',
                      price: true,
                      textEditingController: textPriceController,
                    ),
                  ),
                  sizedHeightBox(2),
                  secondaryText(
                    'Цена за сколько вы готовы браться за этот проект',
                    10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 48, 0, 32),
                      child: customElevatedButton(
                        context,
                        'Откликнуться',
                        onOk: () {
                          if (!_formKeyPrice.currentState.validate()) return;
                          if (indexes.isEmpty) return;
                          List<int> newChipsIndexes =
                              indexes.map((e) => e + 1).toList();

                          _homeCubit
                            ..respondDevToClient(
                                int.parse(textPriceController.value.text),
                                burnProjectId,
                                newChipsIndexes.first);
                        },
                        edgeInsets: const EdgeInsets.all(8.0),
                        width: null,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getBuilder() {
    return BlocConsumer(
        bloc: _homeCubit,
        listener: (context, state) {
          if (state is RespondDevToClientErrorState) {
            print("Error type +${state.status} + ${state.details}");
            showAlert(context, "Ошибка", state.details, () {});
          }
          if (state is RespondDevToClientSuccessState) {
            print("Success type +${state.respond}");
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

  Future<bool> isDeveloper() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('role') != null && prefs.getInt('role') == 2
        ? true
        : false;
  }
}

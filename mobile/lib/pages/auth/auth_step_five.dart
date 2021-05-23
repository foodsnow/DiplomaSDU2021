import 'dart:io';

import 'package:diploma_flutter_app/cubit/auth/auth_cubit.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class StepFive extends StatefulWidget {
  final int role;
  const StepFive(this.role);
  @override
  createState() => _StepFive();
}

class _StepFive extends State<StepFive> {
  File _faceImage;
  File _avatarImage;
  File _identificationImage;
  final textEditingController = TextEditingController();
  AuthCubit _authCubit;

  @override
  void initState() {
    _authCubit = BlocProvider.of<AuthCubit>(context)
      ..sendAuthStepFiveInitState();
    textEditingController.addListener(_printLatestValue);
    super.initState();
  }

  _printLatestValue() {
    setState(() {});
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(context),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mainText('Этап 5'),
              sizedHeightBox(5),
              secondaryText('Загрузите ваши фото'),
              sizedHeightBox(16),
              progressStep(true, true, true, true, true),
              sizedHeightBox(24),
              _getRowImageFile(1, 'Фото лица спереди', _faceImage),
              sizedHeightBox(16),
              _getRowImageFile(2, 'Загрузите профильное фото', _avatarImage),
              sizedHeightBox(16),
              _getRowImageFile(3, 'Загрузите фото\nудостоверения личности',
                  _identificationImage),
              sizedHeightBox(80),
              customElevatedButton(context, 'Завершить', onOk: () {
                _authCubit.sendAuthImagesInfo(
                  _faceImage,
                  _identificationImage,
                  _avatarImage,
                  widget.role,
                );
                Navigator.of(context).pushNamed(
                  '/Home',
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBuilder() {
    return BlocConsumer(
        bloc: _authCubit,
        listener: (context, state) {
          if (state is AuthErrorStepFiveState) {
            print("Error type +${state.status} + ${state.detail}");
            showAlert(context, "Ошибка", state.detail, () {});
          }
          if (state is AuthSuccessStepFiveState) {
            print("Success type +${state.status} + ${state.detail}");
            Navigator.of(context).pushNamed(
              '/Home',
            );
          }
        },
        buildWhen: (prevState, state) =>
            (state is AuthStepFiveInitState) ? true : false,
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        });
  }

  Widget _getRowImageFile(int type, String text, File _image) {
    return Container(
      padding: EdgeInsets.all(21),
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.PrimaryAssentColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          _defaultImages(type, _image),
          sizedWidthBox(13),
          customText(text, 15, CustomColors.MainTextColor, FontWeight.w500),
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
            ? SvgPicture.asset('assets/icons/icon_placeholder.svg')
            : Image.file(_image),
        onPressed: () {
          _showPicker(type);
        },
      ),
    );
  }

  void _showPicker(int type) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Библиотека фотографий'),
                      onTap: () {
                        _imgFromGallery(type);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Камера'),
                    onTap: () {
                      _imgFromCamera(type);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera(int type) async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setImageState(pickedFile, type);
  }

  void setImageState(PickedFile pickedFile, int type) {
    setState(() {
      if (pickedFile != null) {
        switch (type) {
          case 1:
            {
              _faceImage = File(pickedFile.path);
              break;
            }
          case 2:
            {
              _avatarImage = File(pickedFile.path);
              break;
            }
          case 3:
            {
              _identificationImage = File(pickedFile.path);
              break;
            }
        }
      } else {
        print('Изображение не выбрано.');
      }
    });
  }

  _imgFromGallery(int type) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setImageState(pickedFile, type);
  }
}

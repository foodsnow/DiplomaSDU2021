import 'package:diploma_flutter_app/cubit/auth/auth_cubit.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class StepFour extends StatefulWidget {
  final int role;
  const StepFour(this.role);
  @override
  createState() => _StepFour();
}

class _StepFour extends State<StepFour> {
  bool _value = false;
  AuthCubit _authCubit;

  final _formKeyServiceTitle = GlobalKey<FormState>();
  final _formKeyServiceDescription = GlobalKey<FormState>();
  final _formKeyPrice = GlobalKey<FormState>();

  final textTitleController = TextEditingController();
  final textDescriptionController = TextEditingController();
  final textPriceController = TextEditingController();

  @override
  void initState() {
    _authCubit = BlocProvider.of<AuthCubit>(context)
      ..sendAuthStepFourInitState();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textTitleController.dispose();
    textDescriptionController.dispose();
    textPriceController.dispose();
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
              mainText('Этап 4'),
              sizedHeightBox(5),
              secondaryText('Заполните данные о вашей услуге'),
              sizedHeightBox(16),
              progressStep(
                true,
                true,
                true,
                true,
              ),
              sizedHeightBox(49),
              Form(
                key: _formKeyServiceTitle,
                child: customInputTextField(
                  'Название услуги',
                  maxLine: 1,
                  text: true,
                  textEditingController: textTitleController,
                ),
              ),
              sizedHeightBox(24),
              Form(
                key: _formKeyServiceDescription,
                child: customInputTextField(
                  'Описание',
                  maxLine: 4,
                  text: true,
                  textEditingController: textDescriptionController,
                ),
              ),
              sizedHeightBox(24),
              Form(
                key: _formKeyPrice,
                child: customInputTextField(
                  'Цена',
                  maxLine: 1,
                  textEditingController: textPriceController,
                ),
              ),
              sizedHeightBox(24),
              _priceByAgreement(),
              sizedHeightBox(80),
              customElevatedButton(context, 'Далее', onOk: () {
                if (!_formKeyServiceTitle.currentState.validate()) return;
                if (!_formKeyServiceDescription.currentState.validate()) return;
                if (!_formKeyPrice.currentState.validate()) return;

                final authInfo = AuthRequestServiceInfo(
                  serviceTitle: textTitleController.text,
                  serviceDescription: textDescriptionController.text,
                  price: 5000,
                  priceFix: _value,
                  role: widget.role,
                );

                _authCubit.sendAuthServiceInfo(authInfo);
              }),
              getBuilder(),
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
          if (state is AuthErrorStepFourState) {
            print("Error type +${state.status} + ${state.detail}");
            showAlert(context, "Ошибка", state.detail, () {});
          }
          if (state is AuthSuccessStepFourState) {
            print("Success type +${state.status} + ${state.detail}");
            Navigator.of(context).pushNamed(
              '/Step5',
              arguments: widget.role,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        });
  }

  Widget _priceByAgreement() {
    return Row(
      children: [
        _checkBoxState(),
        sizedWidthBox(8),
        customText('Цена по договоренности', 15, CustomColors.MainTextColor,
            FontWeight.w500)
      ],
    );
  }

  Widget _checkBoxState() {
    return SizedBox(
      height: 24,
      width: 24,
      child: IconButton(
        icon: _value
            ? SvgPicture.asset('assets/icons/checked_box.svg')
            : SvgPicture.asset('assets/icons/check.svg'),
        onPressed: () {
          setState(() {
            _value = !_value;
          });
        },
      ),
    );
  }
}

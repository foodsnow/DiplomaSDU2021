import 'package:diploma_flutter_app/cubit/auth/auth_cubit.dart';
import 'package:diploma_flutter_app/services/chopper_services/auth/models/categories_response.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class StepTwo extends StatefulWidget {
  final AuthRequestShortInfo authRequest;
  const StepTwo(this.authRequest);

  @override
  createState() => _StepTwo();
}

class _StepTwo extends State<StepTwo> {
  final dateValue = ValueNotifier<String>("Дата рождения");
  final textPhoneController = TextEditingController();
  AuthCubit _authCubit;
  int _chosenXexValue;
  int _citiesChosenValue;

  final _formKeyPhone = GlobalKey<FormState>();

  @override
  void initState() {
    _authCubit = BlocProvider.of<AuthCubit>(context)
      ..sendAuthStepTwoInitState();
    _authCubit = BlocProvider.of<AuthCubit>(context)..getListCities();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textPhoneController.dispose();
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
              mainText('Этап 2'),
              sizedHeightBox(5),
              secondaryText('Заполните свои данные'),
              sizedHeightBox(16),
              progressStep(
                widget.authRequest.role == 1 ? true : false,
                true,
                true,
              ),
              sizedHeightBox(49),
              customInputTextField(
                widget.authRequest.name,
                isEnabled: false,
              ),
              sizedHeightBox(24),
              customInputTextField(
                widget.authRequest.surname,
                isEnabled: false,
              ),
              sizedHeightBox(24),
              _xexDropDownWidgets(),
              sizedHeightBox(24),
              ValueListenableBuilder(
                valueListenable: dateValue,
                builder: (context, value, widget) {
                  return InkWell(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1965, 3, 5),
                          maxTime: DateTime(2019, 6, 7), onChanged: (date) {
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
              sizedHeightBox(24),
              Form(
                key: _formKeyPhone,
                child: customInputTextField('Номер телефона',
                    textInputType: TextInputType.phone,
                    isPhone: true,
                    textEditingController: textPhoneController),
              ),
              sizedHeightBox(24),
              getBuilder(),
              _typeWidgets
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
          if (state is AuthErrorStepTwoState) {
            print("Error type +${state.status} + ${state.detail}");
            showAlert(context, "Ошибка", state.detail, () {});
          }
          if (state is AuthSuccessStepTwoState) {
            print("Success type +${state.status} + ${state.detail}");

            Navigator.of(context).pushNamed(
              widget.authRequest.role == 1 ? '/Home' : '/Step3',
              arguments: widget.authRequest.role,
            );
          }
        },
        buildWhen: (prevState, state) =>
            (state is AuthStepTwoInitState || state is AuthCitiesResponseState)
                ? true
                : false,
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AuthCitiesResponseState) {
            print("Categories stacks +${state.categories}");

            return getDropDownList(
                _citiesChosenValue, 'Город', state.categories,
                onChanged: (newValue) {
              setState(() {
                _citiesChosenValue = newValue;
              });
            });
          }
          return Container();
        });
  }

  Widget _xexDropDownWidgets() {
    return getDropDownList(_chosenXexValue, 'Пол', [
      Categories(id: 1, title: 'Мужской'),
      Categories(id: 2, title: 'Женский'),
      Categories(id: 3, title: 'Другой'),
    ], onChanged: (newValue) {
      setState(() {
        _chosenXexValue = newValue;
      });
    });
  }

  get _typeWidgets {
    return Column(children: [
      sizedHeightBox(80),
      customElevatedButton(
          context, widget.authRequest.role == 1 ? 'Завершить' : 'Далее',
          onOk: () {
        if (_citiesChosenValue.isNaN) return;
        if (_chosenXexValue.isNaN) return;
        if (!_formKeyPhone.currentState.validate()) return;
        if (dateValue.value == "Дата рождения") return;

        final authRequest = AuthRequestInfo(
            birth_date: dateValue.value,
            gender: _chosenXexValue,
            phone: textPhoneController.text,
            city: _citiesChosenValue,
            role: widget.authRequest.role);
        _authCubit.sendAuthFullInfo(authRequest);

        Navigator.of(context).pushNamed(
          widget.authRequest.role == 2 ? '/Home' : '/Step3',
          arguments: widget.authRequest.role,
        );
      }),
    ]);
  }
}

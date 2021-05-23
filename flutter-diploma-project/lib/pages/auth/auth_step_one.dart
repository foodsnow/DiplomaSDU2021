import 'package:diploma_flutter_app/cubit/auth/auth_cubit.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:diploma_flutter_app/utils/map_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepOne extends StatefulWidget {
  final bool type;
  const StepOne(this.type);

  @override
  createState() => _StepOne();
}

class _StepOne extends State<StepOne> {
  final textEditingController = TextEditingController();
  AuthCubit _authCubit;

  AuthRequestShortInfo authRequest;
  final _formKeyName = GlobalKey<FormState>();
  final _formKeySurname = GlobalKey<FormState>();
  final _formKeyIIN = GlobalKey<FormState>();

  final textNameController = TextEditingController();
  final textSurnameController = TextEditingController();
  final textIINController = TextEditingController();

  @override
  void initState() {
    _authCubit = BlocProvider.of<AuthCubit>(context)
      ..sendAuthStepOneInitState();
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
    textNameController.dispose();
    textSurnameController.dispose();
    textIINController.dispose();
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
              mainText('Этап 1'),
              sizedHeightBox(5),
              secondaryText('Заполните свои данные'),
              sizedHeightBox(16),
              progressStep(widget.type, true),
              sizedHeightBox(49),
              Form(
                key: _formKeyName,
                child: customInputTextField(
                  'Имя',
                  text: true,
                  textEditingController: textNameController,
                ),
              ),
              sizedHeightBox(24),
              Form(
                key: _formKeySurname,
                child: customInputTextField(
                  'Фамилия',
                  text: true,
                  textEditingController: textSurnameController,
                ),
              ),
              sizedHeightBox(24),
              Form(
                key: _formKeyIIN,
                child: customInputTextField('ИИН',
                    iin: true,
                    textEditingController: textIINController,
                    textInputType: TextInputType.number),
              ),
              sizedHeightBox(80),
              customElevatedButton(context, 'Далее', onOk: () {
                if (!_formKeyName.currentState.validate()) return;
                if (!_formKeySurname.currentState.validate()) return;
                if (!_formKeyIIN.currentState.validate()) return;

                authRequest = AuthRequestShortInfo(
                  name: textNameController.text.toString(),
                  surname: textSurnameController.text.toString(),
                  iin: textIINController.text.toString(),
                  role: widget.type.convertToUserType(),
                );

                _authCubit..setRole(widget.type.convertToUserType());
                _authCubit.sendAuthShortInfo(authRequest);
              }),
              getBuilder()
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
          if (state is AuthSuccessStepOneState) {
            print("Success type +${state.status} + ${state.detail}");

            Navigator.of(context).pushNamed(
              '/Step2',
              arguments: authRequest,
            );

            // Navigator.of(context).pushNamed(
            //   '/Step5',
            //   arguments: authRequest.role,
            // );
          }
        },
        buildWhen: (prevState, state) =>
            (state is AuthStepOneInitState) ? true : false,
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        });
  }
}

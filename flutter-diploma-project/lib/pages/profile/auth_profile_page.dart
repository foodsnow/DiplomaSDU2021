import 'package:diploma_flutter_app/cubit/auth/auth_cubit.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthState();
  }
}

class AuthState extends StatefulWidget {
  @override
  createState() => _AuthState();
}

class _AuthState extends State<AuthState> {
  final textEditingController = TextEditingController();

  var focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            mainText('Добро пожаловать!'),
            sizedHeightBox(8),
            secondaryText('Напишите почту'),
            sizedHeightBox(40),
            Form(
              key: _formKey,
              child: customInputTextField('Почта',
                  textEditingController: textEditingController,
                  email: true,
                  textInputType: TextInputType.emailAddress),
            ),
            sizedHeightBox(32),
            customElevatedButton(context, 'Отправить', onOk: () {
              if (_formKey.currentState.validate()) {
                BlocProvider.of<AuthCubit>(context)
                    .getOtpCode(textEditingController.text);
                Navigator.of(context).pushNamed('/OtpSms',
                    arguments: textEditingController.text);
              }
            }),
          ],
        ),
      ),
    );
  }
}

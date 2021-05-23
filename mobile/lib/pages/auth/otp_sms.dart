import 'dart:async';

import 'package:diploma_flutter_app/cubit/auth/auth_cubit.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Otp extends StatefulWidget {
  final String email;
  final String newEmail;
  final bool isGuestCheckOut;

  const Otp({
    Key key,
    @required this.email,
    this.newEmail = "",
    this.isGuestCheckOut,
  }) : super(key: key);

  @override
  _OtpState createState() => new _OtpState();
}

class _OtpState extends State<Otp> with SingleTickerProviderStateMixin {
  AuthCubit _authCubit;

  // Constants
  final int time = 30;
  AnimationController _controller;

  // Variables
  Size _screenSize;
  int _currentDigit;
  int _firstDigit;
  int _secondDigit;
  int _thirdDigit;
  int _fourthDigit;

  Timer timer;
  int totalTimeInSeconds;
  bool _hideResendButton;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;

  // Return "OTP" input field
  get _getInputField {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _otpTextField(_firstDigit),
        _otpTextField(_secondDigit),
        _otpTextField(_thirdDigit),
        _otpTextField(_fourthDigit),
      ],
    );
  }

  // Returns "OTP" input part
  get _getInputPart {
    return Column(
      children: <Widget>[
        sizedHeightBox(50),
        mainText('Введите код', 28),
        sizedHeightBox(8),
        secondaryText('Проверьте почту ${widget.email}'),
        sizedHeightBox(32),
        _getInputField,
        sizedHeightBox(48),
        _hideResendButton ? _getTimerText : _getResendButton,
        sizedHeightBox(15),
        _getOtpKeyboard,
        getBuilder()
      ],
    );
  }

  Widget getBuilder() {
    return BlocConsumer(
        bloc: _authCubit,
        listener: (context, state) {
          if (state is AuthSmsResponseState) {
            print("Loaded token +${state.token}");

            print("Loaded token role +${state.role}");
            _authCubit..setRole(state.role);

            Navigator.of(context).pushNamed(
              state.registered ? '/Home' : '/Roles',
            );
          }
          if (state is AuthSmsErrorState) {
            print("Error type +${state.status} + ${state.detail}");
            showAlert(context, "Ошибка", state.detail, () {});
          }
        },
        buildWhen: (prevState, state) =>
            state is AuthSmsInitState ? true : false,
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        });
  }

  // Returns "Timer" label
  get _getTimerText {
    return Container(
      height: 32,
      child: new Offstage(
        offstage: !_hideResendButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            customText(
                'в течении:', 15, CustomColors.MainTextColor, FontWeight.w500),
            new SizedBox(
              width: 5.0,
            ),
            OtpTimer(_controller, 15.0, Colors.orange)
          ],
        ),
      ),
    );
  }

  // Returns "Resend" button
  get _getResendButton {
    return new InkWell(
      child: new Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: customText('Отправить снова', 15, CustomColors.MainTextColor,
              FontWeight.w500),
        ),
      ),
      onTap: () {
        _authCubit.getOtpCode(widget.email);
        _startCountdown();
      },
    );
  }

  // Returns "Otp" keyboard
  get _getOtpKeyboard {
    return new Container(
        height: _screenSize.width - 80,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4);
                      }),
                  _otpKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5);
                      }),
                  _otpKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7);
                      }),
                  _otpKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8);
                      }),
                  _otpKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new SizedBox(
                    width: 80.0,
                  ),
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: new Icon(
                        Icons.backspace,
                        color: CustomColors.MainTextColor,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_fourthDigit != null) {
                            _fourthDigit = null;
                          } else if (_thirdDigit != null) {
                            _thirdDigit = null;
                          } else if (_secondDigit != null) {
                            _secondDigit = null;
                          } else if (_firstDigit != null) {
                            _firstDigit = null;
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  // Overridden methods
  @override
  void initState() {
    totalTimeInSeconds = time;
    _authCubit = BlocProvider.of<AuthCubit>(context)..sendAuthSmsInitState();

    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _hideResendButton = !_hideResendButton;
              });
            }
          });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: getAppbar(context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: _screenSize.width,
//        padding: new EdgeInsets.only(bottom: 16.0),
          child: _getInputPart,
        ),
      ),
    );
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(int digit) {
    return new Container(
      width: 72,
      height: 72,
      alignment: Alignment.center,
      child: new Text(
        digit != null ? digit.toString() : "",
        style: new TextStyle(
          fontSize: 34.0,
          fontWeight: FontWeight.w600,
          color: CustomColors.MainTextColor,
        ),
      ),
      decoration: new BoxDecoration(
          border: Border.all(color: CustomColors.TextFieldEnabledBorderColor),
          color: Colors.transparent,
          borderRadius: new BorderRadius.circular(20)),
    );
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: new Container(
          height: 80.0,
          width: 80.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: new Center(
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 30.0,
                color: CustomColors.MainTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;

        var otp = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();

        _authCubit.validateOtpCode(widget.email, otp);
      }
    });
  }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  void clearOtp() {
    _fourthDigit = null;
    _thirdDigit = null;
    _secondDigit = null;
    _firstDigit = null;
    setState(() {});
  }
}

class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  double fontSize;
  Color timeColor = CustomColors.MainTextColor;

  OtpTimer(this.controller, this.fontSize, this.timeColor);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = controller.duration;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return new Text(
            timerString,
            style: new TextStyle(
                fontSize: fontSize,
                color: timeColor,
                fontWeight: FontWeight.w600),
          );
        });
  }
}

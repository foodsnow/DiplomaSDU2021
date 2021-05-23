import 'dart:ui';

import 'package:diploma_flutter_app/cubit/home/home_cubit.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/burn_models/respond.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDialogBox extends StatefulWidget {
  final descriptions, text;
  final Image img;
  final Respond respond;

  const CustomDialogBox(
      {Key key, this.descriptions, this.text, this.img, this.respond})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  HomeCubit _homeCubit;

  @override
  void initState() {
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(24, 50, 24, 50),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: SvgPicture.asset(
                  'assets/images/check_image.svg',
                  width: 76,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(
                  fontSize: 15,
                  color: CustomColors.MainTextColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              customElevatedButton(
                context,
                'Принять',
                onOk: () {
                  _homeCubit
                    ..acceptClientResponse(
                        widget.respond.id,
                        true,
                        widget.respond.developerId.id,
                        widget.respond.burnProjectId);
                  Navigator.of(context).pop();
                },
                width: null,
                edgeInsets: EdgeInsets.all(8),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

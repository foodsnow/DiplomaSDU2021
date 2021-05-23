import 'package:diploma_flutter_app/cubit/home/home_cubit.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/burn_models/respond.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diploma_flutter_app/utils/map_utils.dart';

class AcceptOrDeclineItemsPage extends StatefulWidget {
  final Respond respond;

  AcceptOrDeclineItemsPage({Key key, this.respond}) : super(key: key);

  @override
  createState() => _AcceptOrDeclineItemsPage();
}

class _AcceptOrDeclineItemsPage extends State<AcceptOrDeclineItemsPage> {
  HomeCubit _homeCubit;

  @override
  void initState() {
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizedHeightBox(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 20,
                child: ClipOval(
                  child: Image.network(
                    'https://i.picsum.photos/id/431/200/200.jpg?hmac=htJbypAbF5_h67SAU-qYOJLyDwNNHcHSfL67TITi2hc',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              sizedWidthBox(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mainText(
                      '${widget.respond.developerId.user.name} ${widget.respond.developerId.user.surname}',
                      15),
                  customText(widget.respond.stacksId.convertCategoryNameToId(),
                      14, CustomColors.PrimaryColor, FontWeight.bold),
                  secondaryText('откликнулась на вашу услугу', 12),
                ],
              ),
              Spacer(),
              secondaryText('12:31', 12),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 4, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: widget.respond.acceptBool == null,
                  child: getOutlinedButton(
                      "Отклонить", CustomColors.RedColor, CustomColors.RedColor,
                      () {
                    _homeCubit
                      ..acceptClientResponse(
                          widget.respond.id,
                          false,
                          widget.respond.developerId.id,
                          widget.respond.burnProjectId);
                    _homeCubit
                      ..pageResponds = 1
                      ..getAllRespondProjects();
                  }),
                ),
                sizedWidthBox(10),
                Visibility(
                  visible: widget.respond.acceptBool == null,
                  child: getOutlinedButton("Принять", CustomColors.PrimaryColor,
                      CustomColors.PrimaryColor, () {
                    _homeCubit
                      ..acceptClientResponse(
                          widget.respond.id,
                          true,
                          widget.respond.developerId.id,
                          widget.respond.burnProjectId);

                    _homeCubit
                      ..pageResponds = 1
                      ..getAllRespondProjects();

                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return CustomDialogBox(
                    //         descriptions:
                    //             "Принимая отлик Вы даете\nсогласие на разглашение ваших\nконтактных данных этому\nзаказщику.",
                    //         text: "Yes",
                    //       );
                    //     });
                  }),
                ),
                Visibility(
                  visible: widget.respond.acceptBool == false,
                  child: getOutlinedButton("Отклонено", CustomColors.RedColor,
                      CustomColors.RedColor, () {}),
                ),
                Visibility(
                  visible: widget.respond.acceptBool == true,
                  child: getOutlinedButton("Посмотреть контакты",
                      CustomColors.PrimaryColor, CustomColors.PrimaryColor, () {
                    Navigator.pushNamed(context, '/AccountDetails',
                        arguments: widget.respond.developerId.id);
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:diploma_flutter_app/services/chopper_services/auth/models/categories_response.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/map_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

Widget getReviewTextField() {
  return Theme(
    data: new ThemeData(
      primaryColor: CustomColors.SecondaryTextColor,
      primaryColorDark: CustomColors.SecondaryTextColor,
    ),
    child: TextFormField(
      autofocus: true,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: CustomColors.MainTextColor,
      style: TextStyle(color: CustomColors.MainTextColor),
      decoration: InputDecoration(
        suffixIcon: InkWell(
            onTap: () {
              print('Hello');
            },
            child: Ink(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                child: customText(
                  'Опубликовать',
                  10,
                  CustomColors.PrimaryColor,
                  FontWeight.normal,
                ),
              ),
            )),
        isCollapsed: true,
        labelText: 'Добавьте коментарий',
        alignLabelWithHint: true,
        labelStyle: TextStyle(
            color: CustomColors.MainTextColor,
            fontSize: 15,
            fontWeight: FontWeight.normal),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: CustomColors.SecondaryTextColor)),
        contentPadding: EdgeInsets.all(20),
        border: const OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(16.0),
            ),
            borderSide: BorderSide(color: CustomColors.SecondaryTextColor)),
      ),
    ),
  );
}

void showActionBottomSheet(
  BuildContext context,
) {
  showModalBottomSheet(
    context: context,
    elevation: 0,
    barrierColor: Colors.black.withAlpha(100),
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            Container(
              height: 94,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(const Radius.circular(16)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      print("hello =++ ");
                    },
                    child: Ink(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/delete_icon.svg'),
                          sizedWidthBox(12),
                          mainText('Удалить', 12),
                        ],
                      ),
                    ),
                  ),
                  getItemDivider(),
                  InkWell(
                    onTap: () {
                      print("hello worldssss =++ ");
                    },
                    child: Ink(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/archive_icon.svg'),
                          sizedWidthBox(12),
                          mainText('Архивировать', 12),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            sizedHeightBox(6),
            Container(
              height: 46,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(const Radius.circular(16)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      mainText('Отмена', 12),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget getDropDownList(int _chosenValue, String title, List<Categories> _items,
    {Function onChanged, int cityId}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColors.SecondaryTextColor)),
    child: DropdownButton<int>(
      isExpanded: true,
      value: _chosenValue,
      icon: SvgPicture.asset('assets/icons/down_icon.svg'),
      iconSize: 11,
      underline: SizedBox(),
      onChanged: (int newValue) {
        onChanged(newValue);
      },
      hint: secondaryText(title, 15),
      items: _items.map((Categories value) {
        return DropdownMenuItem<int>(
          value: value.id,
          child: Text(value.title),
        );
      }).toList(),
    ),
  );
}

Widget getWrappedChips(
    List<String> chips, List<int> indexes, Function onSelectedChips) {
  return Wrap(
    alignment: WrapAlignment.start,
    spacing: 8,
    children: [
      for (var index = 0; index < chips.length; index++)
        ChoiceChip(
          label: mainText(chips[index], 10),
          selectedColor: CustomColors.PrimaryColor,
          backgroundColor: CustomColors.ContainerBackgroundColor,
          onSelected: (bool selected) {
            onSelectedChips(index);
          },
          selected: indexes.contains(index),
        ),
    ],
  );
}

Widget getOutlinedButton(
    String title, Color borderColor, Color textColor, Function onOk) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      primary: textColor,
      backgroundColor: Colors.transparent,
      side: BorderSide(color: borderColor, width: 1),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32))),
    ),
    onPressed: () {
      onOk();
    },
    child: Text(title),
  );
}

Widget getBottomAppBar(
  TabBar _tabBar,
  String title,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 22,
            color: CustomColors.MainTextColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      sizedHeightBox(10),
      Padding(
        padding: const EdgeInsets.only(left: 18),
        child: _tabBar,
      ),
      sizedHeightBox(10),
      Container(
        width: double.infinity,
        height: 8,
        color: CustomColors.ContainerBackgroundColor,
      ),
    ],
  );
}

Widget getItemDivider() {
  return Container(
    width: double.infinity,
    height: 2,
    decoration: BoxDecoration(color: CustomColors.ContainerBackgroundColor),
  );
}

Widget getSkillsWidget(String text) {
  return Container(
      decoration: BoxDecoration(
        color: CustomColors.ContainerBackgroundColor,
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: mainText(text, 10),
      ));
}

Widget progressStep(bool type,
    [bool stepOne = false,
    bool stepTwo = false,
    bool stepThree = false,
    bool stepFour = false]) {
  return type
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            shapeColorizedSteps(stepOne ? true : false),
            sizedWidthBox(8),
            shapeColorizedSteps(stepTwo ? true : false),
            sizedWidthBox(8),
            shapeColorizedSteps(stepThree ? true : false),
            sizedWidthBox(8),
            shapeColorizedSteps(stepFour ? true : false),
          ],
        )
      : Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            shapeColorizedSteps(stepOne ? true : false),
            sizedWidthBox(8),
            shapeColorizedSteps(stepTwo ? true : false),
          ],
        );
}

Widget customElevatedButton(BuildContext context, String text,
    {Color color = CustomColors.White,
    double fontSize = 15,
    Function onOk,
    EdgeInsets edgeInsets = const EdgeInsets.all(19.0),
    double width = double.infinity}) {
  return Container(
    width: width,
    child: ElevatedButton(
      onPressed: () {
        onOk();
      },
      style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(32.0),
          ),
          primary: CustomColors.PrimaryColor),
      child: Padding(
        padding: edgeInsets,
        child: customText(text, fontSize, color, FontWeight.bold),
      ),
    ),
  );
}

Widget customInputTextField(
  String labelTxt, {
  int maxLine = 1,
  TextEditingController textEditingController,
  bool email = false,
  bool iin = false,
  bool text = false,
  TextInputType textInputType = TextInputType.text,
  bool isEnabled = true,
  String icon = 'assets/icons/check.svg',
  bool isPhone = false,
  bool autoFocus = false,
  bool price = false,
}) {
  return TextFormField(
    autofocus: autoFocus,
    enabled: isEnabled,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    maxLines: maxLine,
    inputFormatters: isPhone
        ? [
            MaskTextInputFormatter(
                mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')})
          ]
        : [],
    keyboardType: textInputType,
    textAlign: TextAlign.start,
    controller: textEditingController,
    textAlignVertical: TextAlignVertical.center,
    style: TextStyle(
      color: CustomColors.MainTextColor,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    validator: (value) {
      if (value == null) return null;
      if (email) {
        if (value.length < 3 || value.isEmpty)
          return 'длина строки должен быть больше 2';
        if (!value.contains('@')) return 'Должен содержать символ @';
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value);
        if (!emailValid) return "Неверный формат почты";
      }
      if (iin) {
        if (value.length != 12) return 'длина строки должен быть равен 12';
      }
      if (text) {
        if (value.length < 1 || value.isEmpty)
          return 'длина строки должен быть больше 1';
      }
      if (isPhone) {
        if (value.length != 18 || value.isEmpty) return 'Заполните поле';
      }
      if(price) {
        if(isNumericUsing_tryParse(value) == false) return 'Введите только цифры';
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: labelTxt,
      alignLabelWithHint: true,
      labelStyle: TextStyle(
          color: CustomColors.MainTextColor,
          fontSize: 15,
          fontWeight: FontWeight.normal),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: CustomColors.SecondaryTextColor)),
      contentPadding: EdgeInsets.only(left: 24, bottom: 26, top: 13, right: 24),
      hintStyle: TextStyle(
        color: CustomColors.MainTextColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SvgPicture.asset(
          icon,
        ),
      ),
      border: const OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(16.0),
          ),
          borderSide: BorderSide(color: Colors.red)),
    ),
  );
}

Widget shapeColorizedSteps(bool hasStep) {
  return Container(
    width: 72,
    height: 4,
    color:
        hasStep ? CustomColors.PrimaryColor : CustomColors.PrimaryAssentColor,
  );
}

Widget mainText(String text, [double fontSize = 22]) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontSize,
        color: CustomColors.MainTextColor,
        fontWeight: FontWeight.bold),
  );
}

Widget secondaryText(String text, [double fontSize = 15]) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontSize,
        color: CustomColors.SecondaryTextColor,
        fontWeight: FontWeight.w500),
  );
}

Widget customText(
    String text, double fontSize, Color color, FontWeight weight) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, color: color, fontWeight: weight),
  );
}

Widget getAppbar(
  BuildContext context,
) {
  return new AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: new InkWell(
      borderRadius: BorderRadius.circular(30.0),
      child: new Icon(
        Icons.arrow_back,
        color: CustomColors.MainTextColor,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    ),
    centerTitle: true,
  );
}

Widget sizedHeightBox(double customHeight) {
  return SizedBox(
    height: customHeight,
  );
}

Widget sizedWidthBox(double customWidth) {
  return SizedBox(
    width: customWidth,
  );
}

void showAlert(BuildContext context, String title, String msg, Function onOk,
    {Function onCancel}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            // child: new Text(Localization.of(context).getValue(cancel)),
            onPressed: () {
              if (onCancel != null) {
                onCancel();
              }
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: mainText('Ok', 15),
            onPressed: () {
              onOk();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget getRoundedImage(double radius, {ImageProvider im, Widget child}) {
  if (im != null)
    return Container(
        width: radius * 2.0,
        height: radius * 2.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(fit: BoxFit.cover, image: im)));
  else
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: child);
}

Widget getProgress({bool wrap = false}) {
  if (wrap) {
    return Center(
      heightFactor: 0,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }
  return Stack(children: <Widget>[
    Opacity(
      opacity: 0.6,
      child: Container(
        color: Colors.grey,
      ),
    ),
    Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    )
  ]);
}

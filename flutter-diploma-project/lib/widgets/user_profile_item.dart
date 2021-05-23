import 'package:diploma_flutter_app/services/chopper_services/home/models/skills_id.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

Widget getUserTitleAndDesc(String fullName, String categoryName) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
    child: Row(
      children: [
        Image(image: AssetImage('assets/images/user_avatar.jpg')),
        sizedWidthBox(7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
              fullName != null ? fullName : "",
              14,
              CustomColors.MainTextColor,
              FontWeight.w500,
            ),
            customText(
              categoryName != null ? categoryName : "",
              12,
              CustomColors.PrimaryColor,
              FontWeight.bold,
            ),
          ],
        )
      ],
    ),
  );
}

Widget getSkillsList(List<SkillsId> skillsId) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
    child: Row(
      children: [
        for (var i in skillsId) getSkillsWidget(i.title),
      ],
    ),
  );
}

Widget getStarsAndPrice(double rating, int ratingCount, double price) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/icons/star_icon.svg'),
            sizedWidthBox(2),
            customText(rating.toString(), 14, CustomColors.OrangeColor,
                FontWeight.w500),
            sizedWidthBox(2),
            customText("(${ratingCount.toString()})", 14,
                CustomColors.SecondaryTextColor, FontWeight.w500),
          ],
        ),
        Row(
          children: [
            customText('от', 10, CustomColors.TextColor, FontWeight.w500),
            customText(
                price.toString(), 15, CustomColors.TextColor, FontWeight.w500),
            customText('тг', 10, CustomColors.TextColor, FontWeight.w500),
          ],
        )
      ],
    ),
  );
}

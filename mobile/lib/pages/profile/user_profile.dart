import 'package:diploma_flutter_app/cubit/auth/auth_cubit.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/dev_service.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/skills_id.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/stacks_id.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/user.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:diploma_flutter_app/utils/map_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class UserProfile extends StatefulWidget {
  @override
  createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context)..getProfInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: getBuilder());
  }

  Widget getBuilder() {
    return BlocConsumer<AuthCubit, AuthCubitState>(listener: (context, state) {
      if (state is AuthProfInfoErrorState) {
        print("Error type +${state.status} + ${state.detail}");
        showAlert(context, "Ошибка", state.detail, () {});
      }
    }, builder: (context, state) {
      if (state is AuthLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is AuthProfInfoErrorState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context)..getProfInfo();
              },
              icon: Icon(Icons.refresh),
            ),
            const SizedBox(height: 15),
            Text(state.detail, textAlign: TextAlign.center),
          ],
        );
      }
      if (state is AuthProfInfoResponseState) {
        print("Success fetch profile info +++++++++");
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            editProfilePageIcon(),
            getStatusProfileWidgets(
                state.developer.user,
                state.developer.stacksId != null
                    ? state.developer.stacksId.title
                    : ""),
            Visibility(
              visible: state.developer.user.role == 1,
              child: getClientInfo(state.developer.user),
            ),
            Visibility(
                visible: state.developer.user.role == 2,
                child: Column(
                  children: [
                    getDeveloperInfo(
                        state.developer.user, state.developer.education),
                    getProfInfo(
                        state.developer.workExperience,
                        state.developer.stacksId,
                        state.developer.skillsId,
                        state.developer.about),
                    state.developer.devService != null
                        ? getMyServiceInfo(state.developer.devService)
                        : Container(),
                    getAllReviews(),
                  ],
                ))
          ],
        );
      }
      return Container();
    });
  }

  Widget getStatusProfileWidgets(User user, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Row(
        children: [
          Image(image: AssetImage('assets/images/user_avatar.jpg')),
          sizedWidthBox(7),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                '${user.surname} ${user.name}',
                14,
                CustomColors.MainTextColor,
                FontWeight.w500,
              ),
              Visibility(
                visible: title.isNotEmpty,
                child: customText(
                  title,
                  12,
                  CustomColors.PrimaryColor,
                  FontWeight.bold,
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget getClientInfo(User user) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getRowEditInfo(
            "Личная информация",
            onChanged: () {},
          ),
          sizedHeightBox(8),
          getItemDivider(),
          containerTitleAndDesc('Пол', user.gender.convertToLongXex()),
          getItemDivider(),
          containerTitleAndDesc('Дата рождения', user.birthDate),
          getItemDivider(),
          containerTitleAndDesc('Номер телефона', user.phone),
          getItemDivider(),
          containerTitleAndDesc('Город', user.city),
        ],
      ),
    );
  }

  Widget getDeveloperInfo(User user, String education) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getRowEditInfo(
            "Личная информация",
            onChanged: () {},
          ),
          sizedHeightBox(8),
          getItemDivider(),
          containerTitleAndDesc('Пол', user.gender.convertToLongXex()),
          getItemDivider(),
          containerTitleAndDesc('Дата рождения', user.birthDate),
          getItemDivider(),
          containerTitleAndDesc('Номер телефона', user.phone),
          getItemDivider(),
          containerTitleAndDesc('Город', user.city),
          getItemDivider(),
          containerTitleAndDesc('Образование', education),
        ],
      ),
    );
  }

  Widget getProfInfo(String experience, StacksId stacksIds,
      List<SkillsId> skillsId, String about) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getRowEditInfo(
            "Профессиональные данные",
            onChanged: () {},
          ),
          sizedHeightBox(8),
          getItemDivider(),
          getSkillsWidgets(skillsId),
          getItemDivider(),
          getTitleAndDesc('О себе', about),
          getItemDivider(),
          getItemDivider(),
          containerTitleAndDesc('Опыт работы', experience),
        ],
      ),
    );
  }

  Widget getMyServiceInfo(DevService service) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getRowEditInfo(
            "Моя услуга",
            onChanged: () {},
          ),
          sizedHeightBox(8),
          getItemDivider(),
          getTitleAndDesc(service.serviceTitle, service.serviceDescription),
        ],
      ),
    );
  }

  Widget getRowEditInfo(String title, {Function onChanged}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        mainText(title, 15),
        InkWell(
          onTap: () {
            onChanged.call();
          },
          child: Ink(
            child: customText(
              'Изменить',
              12,
              CustomColors.PrimaryColor,
              FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Widget getReviewRatingEachOne(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23.5, 0, 32, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customText(text, 12, CustomColors.TextColor, FontWeight.w500),
          Row(
            children: [
              SvgPicture.asset('assets/icons/star_icon.svg'),
              sizedWidthBox(2),
              customText('4.9', 14, CustomColors.OrangeColor, FontWeight.w500),
            ],
          ),
        ],
      ),
    );
  }

  Widget editProfilePageIcon() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          margin: EdgeInsets.only(bottom: 65),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/ux_ui_image.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 25,
          child: IconButton(
            iconSize: 60,
            icon: Image.asset(
              'assets/images/pencil.png',
              fit: BoxFit.cover,
            ),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  Widget getSkillsWidgets(List<SkillsId> skillsId) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Row(
        children: [
          for (var i in skillsId) getSkillsWidget(i.title),
        ],
      ),
    );
  }

  Widget getTitleAndDesc(String title, String desc) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mainText(title, 18),
            sizedHeightBox(16),
            customText(desc, 14, CustomColors.MainTextColor, FontWeight.w500),
          ],
        ));
  }

  Widget getAllReviews() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 35, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '29 Отзывов',
            style: TextStyle(
              fontSize: 12,
              color: CustomColors.MainTextColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          customText(
            'Все',
            12,
            CustomColors.PrimaryColor,
            FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget sheetTitleAndDesc(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 6, 0, 6),
      child: getTitleAndDescContainer(title, desc),
    );
  }

  Widget containerTitleAndDesc(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          secondaryText(title, 12),
          sizedHeightBox(4),
          mainText(desc, 14),
        ],
      ),
    );
  }

  Widget getTitleAndDescContainer(String title, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        secondaryText(title, 12),
        sizedHeightBox(4),
        mainText(desc, 14),
      ],
    );
  }
}

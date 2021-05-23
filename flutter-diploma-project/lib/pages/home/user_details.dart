import 'package:diploma_flutter_app/cubit/home/home_cubit.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/dev_service.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/developer.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/skills_id.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetails extends StatefulWidget {
  final int id;

  const UserDetails(this.id);

  @override
  createState() => _UserDetails();
}

class _UserDetails extends State<UserDetails> {
  bool dropReview;
  RangeValues _rangeSliderDiscreteValues;

  Future<bool> _isDeveloperState;

  @override
  void initState() {
    dropReview = false;
    _isDeveloperState = isDeveloper();
    BlocProvider.of<HomeCubit>(context)..fetchDeveloperInfo(widget.id);
    _rangeSliderDiscreteValues = RangeValues(0, 5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[getSliverAppbar()];
          },
          body: SingleChildScrollView(
            child: getBuilder(),
          )),
    );
  }

  Widget getBuilder() {
    return BlocConsumer<HomeCubit, HomeCubitState>(listener: (context, state) {
      if (state is HomeDeveloperErrorState) {
        print("Error type +${state.status} + ${state.detail}");
        showAlert(context, "Ошибка", state.detail, () {});
      }
    }, builder: (context, state) {
      if (state is HomeLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is HomeDeveloperInfoState) {
        print("Succeessssss  + ${state.developer}");
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            getStatusProfileWidgets(state.developer),
            getItemDivider(),
            getSkillsWidgets(state.developer.skillsId),
            getItemDivider(),
            if (state.developer.devService != null)
              getTitleAndDesc(state.developer.devService),
            getItemDivider(),
            getReviewStars(),
            getItemDivider(),
            getAllReviews(),
            FutureBuilder<bool>(
                future: _isDeveloperState,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    return Visibility(visible: !snapshot.data, child: getBtn());
                  } else {
                    return Container();
                  }
                }),
          ],
        );
      }
      return Container();
    });
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

  Widget getSliverAppbar() {
    return SliverAppBar(
      expandedHeight: 171.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text("UX-UI",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            )),
        background: Image.network(
          "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
          fit: BoxFit.cover,
        ),
        // background: Image.asset(
        //   'assets/images/ux_image.png',
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }

  Widget getStatusProfileWidgets(Developer developer) {
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
                '${developer.user.surname} ${developer.user.name}',
                14,
                CustomColors.MainTextColor,
                FontWeight.w500,
              ),
              customText(
                '${developer.stacksId != null ? developer.stacksId.title : ""}',
                12,
                CustomColors.PrimaryColor,
                FontWeight.bold,
              ),
            ],
          ),
          Spacer(),
          IconButton(
              icon: SvgPicture.asset('assets/icons/down_icon.svg'),
              onPressed: () {
                showMaterialModalBottomSheet(
                  expand: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    controller: ModalScrollController.of(context),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  'assets/icons/sheet_indicator.svg'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 20, 0, 8),
                            child: sheetProfileWidgets(
                                "${developer.user.surname} ${developer.user.name}",
                                developer.stacksId != null
                                    ? developer.stacksId.title
                                    : ""),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 8, 0, 8),
                            child: mainText('Информация о разработчике', 15),
                          ),
                          getItemDivider(),
                          sheetTitleAndDesc(
                              'Дата рождения', developer.user.birthDate),
                          getItemDivider(),
                          sheetTitleAndDesc('Город', developer.user.city),
                          Visibility(
                              visible: developer.user.phone != "",
                              child: getItemDivider()),
                          Visibility(
                              visible: developer.user.phone != "",
                              child: sheetTitleAndDesc(
                                  'Номер телефона', developer.user.phone)),
                          getItemDivider(),
                          sheetTitleAndDesc('О себе', developer.about),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget getSkillsWidgets(List<SkillsId> skillsId) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Row(
        children: [
          for (var i in skillsId) getSkillsWidget(i.title),
        ],
      ),
    );
  }

  Widget getTitleAndDesc(DevService devService) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 30),
        child: Column(
          children: [
            mainText(devService.serviceTitle, 18),
            sizedHeightBox(16),
            customText(devService.serviceDescription, 14,
                CustomColors.MainTextColor, FontWeight.w500),
          ],
        ));
  }

  Widget getReviewStars() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/icons/star_icon.svg'),
                sizedWidthBox(2),
                customText(
                    '4.9', 14, CustomColors.OrangeColor, FontWeight.w500),
                sizedWidthBox(2),
                customText('(29)', 14, CustomColors.SecondaryTextColor,
                    FontWeight.w500),
              ],
            ),
            IconButton(
                icon: dropReview
                    ? SvgPicture.asset('assets/icons/up_icon.svg')
                    : SvgPicture.asset('assets/icons/down_icon.svg'),
                onPressed: () {
                  setState(() {
                    dropReview = !dropReview;
                  });
                  if (dropReview) showTextFieldBottomSheet(context);
                }),
          ],
        ),
      ),
      Visibility(
          visible: dropReview,
          child: Column(
            children: [
              getReviewRatingEachOne('Коммуникация'),
              getReviewRatingEachOne('Качество работы'),
              getReviewRatingEachOne('Соответствие описанию'),
            ],
          )),
      Visibility(visible: dropReview, child: sizedHeightBox(8))
    ]);
  }

  void showTextFieldBottomSheet(BuildContext context) {
    showModalBottomSheet(
        barrierColor: Colors.black.withAlpha(100),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
              width: double.infinity,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            getStars(_rangeSliderDiscreteValues.start.round()),
                            getStars(1),
                            getStars(2),
                            getStars(3),
                            getStars(4),
                            getStars(_rangeSliderDiscreteValues.end.round())
                          ],
                        ),
                      ),
                      RangeSlider(
                        inactiveColor: Colors.orangeAccent,
                        activeColor: Colors.orangeAccent,
                        values: _rangeSliderDiscreteValues,
                        min: 0,
                        max: 5,
                        divisions: 1,
                        labels: RangeLabels(
                          _rangeSliderDiscreteValues.start.round().toString(),
                          _rangeSliderDiscreteValues.end.round().toString(),
                        ),
                        onChanged: (values) {
                          setState(() {
                            _rangeSliderDiscreteValues = values;
                          });
                        },
                      ),
                      sizedHeightBox(10),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image(
                              image:
                                  AssetImage('assets/images/user_avatar.jpg')),
                          sizedWidthBox(10),
                          Expanded(
                            child: getReviewTextField(),
                          ),
                        ],
                      ),
                    ]),
              ),
            ));
  }

  Widget getStars(int value) {
    return Row(
      children: [
        customText(
            value.toString(), 14, CustomColors.OrangeColor, FontWeight.w500),
        sizedWidthBox(2),
        SvgPicture.asset('assets/icons/star_icon.svg'),
      ],
    );
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

  Widget getBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(85, 40, 85, 0),
      child: customElevatedButton(context, 'Откликнуться', onOk: () {
        BlocProvider.of<HomeCubit>(context)..inContact(widget.id);
        Navigator.of(context).pushNamed(
          '/Home',
        );
      }, edgeInsets: const EdgeInsets.all(8)),
    );
  }

  Widget sheetProfileWidgets(String fullName, String stackTitle) {
    return Row(
      children: [
        Image(image: AssetImage('assets/images/user_avatar.jpg')),
        sizedWidthBox(7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
              fullName,
              14,
              CustomColors.MainTextColor,
              FontWeight.w500,
            ),
            customText(
              stackTitle,
              12,
              CustomColors.PrimaryColor,
              FontWeight.bold,
            ),
          ],
        )
      ],
    );
  }

  Widget sheetTitleAndDesc(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 6, 0, 6),
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

  Future<bool> isDeveloper() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('role') != null && prefs.getInt('role') == 2
        ? true
        : false;
  }
}

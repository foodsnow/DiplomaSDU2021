import 'package:diploma_flutter_app/cubit/home/home_cubit.dart';
import 'package:diploma_flutter_app/services/chopper_services/auth/models/categories_response.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  createState() => _FilterBottomSheet();
}

class _FilterBottomSheet extends State<FilterBottomSheet> {
  TextEditingController controller;
  List<int> indexes = [];
  RangeValues _rangeSliderDiscreteValues;
  List<String> chips = [
    'Backend',
    'Frontend',
    'Designer',
    'PM',
    'DS',
    'IOS',
    'Android'
  ];
  int _chosenValue;
  String searchValue;

  @override
  void initState() {
    super.initState();
    _chosenValue = BlocProvider.of<HomeCubit>(context).cityId;
    _rangeSliderDiscreteValues = RangeValues(
        BlocProvider.of<HomeCubit>(context).minPrice,
        BlocProvider.of<HomeCubit>(context).maxPrice);
    controller = TextEditingController(
        text: BlocProvider.of<HomeCubit>(context).searchKey);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: mainText('Добавить фильтр', 17),
          ),
          sizedHeightBox(24),
          getAppBarTitle(),
          sizedHeightBox(24),
          mainText('Категория', 17),
          sizedHeightBox(16),
          getWrappedChips(chips, indexes, (index) {
            setState(() {
              indexes.contains(index)
                  ? indexes.remove(index)
                  : indexes.add(index);
            });
          }),
          sizedHeightBox(24),
          mainText('Цена', 17),
          sizedHeightBox(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText('${_rangeSliderDiscreteValues.start}k', 15,
                  CustomColors.PrimaryColor, FontWeight.bold),
              customText('${_rangeSliderDiscreteValues.end / 2}k', 15,
                  CustomColors.PrimaryColor, FontWeight.bold),
              customText('${_rangeSliderDiscreteValues.end}k', 15,
                  CustomColors.PrimaryColor, FontWeight.bold)
            ],
          ),
          sizedHeightBox(24),
          RangeSlider(
            inactiveColor: CustomColors.PrimaryColor,
            activeColor: CustomColors.PrimaryColor,
            values: _rangeSliderDiscreteValues,
            min: 0,
            max: 400,
            divisions: 20,
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
          sizedHeightBox(32),
          mainText('Город', 17),
          sizedHeightBox(16),
          getDropDownList(_chosenValue, 'Город', [
            Categories(id: 0, title: 'Не выбран'),
            Categories(id: 1, title: 'Almaty'),
            Categories(id: 2, title: 'Astana'),
            Categories(id: 3, title: 'Uralsk'),
            Categories(id: 4, title: 'Oskemen'),
            Categories(id: 5, title: 'Atyrau'),
            Categories(id: 6, title: 'Pavlodar'),
          ], onChanged: (newValue) {
            setState(() {
              _chosenValue = newValue;
            });
          }),
          sizedHeightBox(16),
          Align(
            alignment: Alignment.topCenter,
            child: customElevatedButton(context, 'Применить', onOk: () {
              BlocProvider.of<HomeCubit>(context)
                ..fetchProfileInfo()
                ..page = 1
                ..cityId = _chosenValue
                ..searchKey = controller.text
                ..minPrice = _rangeSliderDiscreteValues.start.roundToDouble()
                ..maxPrice = _rangeSliderDiscreteValues.end.roundToDouble();
              Navigator.pop(context);
            }, width: null, edgeInsets: EdgeInsets.all(8)),
          ),
        ],
      ),
    );
  }

  Widget getAppBarTitle() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.ContainerBackgroundColor,
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: TextField(
        controller: controller,
        cursorColor: CustomColors.MainTextColor,
        style: TextStyle(color: CustomColors.MainTextColor),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelStyle: TextStyle(color: CustomColors.MainTextColor),
          contentPadding: EdgeInsets.fromLTRB(0.0, 1.0, 1.0, 0.0),
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 10, 0),
            child: GestureDetector(
                onTap: () {
                  print('Hello');
                },
                child: SvgPicture.asset('assets/icons/search_icon.svg')),
          ),
          prefixIconConstraints: BoxConstraints(
            minHeight: 18,
            minWidth: 18,
          ),
          hintText: 'Поиск',
          hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: CustomColors.SecondaryTextColor),
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          searchValue = value;
        },
      ),
    );
  }
}

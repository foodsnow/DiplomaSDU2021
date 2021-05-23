import 'package:diploma_flutter_app/cubit/auth/auth_cubit.dart';
import 'package:diploma_flutter_app/services/chopper_services/auth/models/categories_response.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepThree extends StatefulWidget {
  final int role;

  const StepThree(this.role);

  @override
  createState() => _StepThree();
}

class _StepThree extends State<StepThree> {
  bool _value = false;
  AuthCubit _authCubit;

  final stacksNotifier = ValueNotifier<List<Categories>>([]);
  final skillsNotifier = ValueNotifier<List<Categories>>([]);

  final _formKeyAbout = GlobalKey<FormState>();
  final _formKeyExperience = GlobalKey<FormState>();
  final _formKeyEducation = GlobalKey<FormState>();
  final _formKeyWorkPlace = GlobalKey<FormState>();

  int _stacksChosenValue = 1;

  final textAboutController = TextEditingController();
  final textExperienceController = TextEditingController();
  final textEducationController = TextEditingController();
  final textWorkPlaceController = TextEditingController();

  List<String> chips = [
    'Python',
    'Javasciprt',
    'Java',
    'Ruby',
    'Django',
    'Swift',
    'Figma',
  ];

  List<int> indexes = [];

  @override
  void initState() {
    _authCubit = BlocProvider.of<AuthCubit>(context)
      ..sendAuthStepThreeInitState();
    _authCubit = BlocProvider.of<AuthCubit>(context)..getListStacks();
    _authCubit = BlocProvider.of<AuthCubit>(context)..getListSkills();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textAboutController.dispose();
    textExperienceController.dispose();
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
              mainText('Этап 3'),
              sizedHeightBox(5),
              secondaryText('Заполните профессиональные данные'),
              sizedHeightBox(16),
              progressStep(
                true,
                true,
                true,
                true,
              ),
              sizedHeightBox(49),
              ValueListenableBuilder(
                valueListenable: stacksNotifier,
                builder: (context, value, widget) {
                  return getDropDownList(_stacksChosenValue, 'Категория', value,
                      onChanged: (newValue) {
                    setState(() {
                      _stacksChosenValue = newValue;
                    });
                  });
                },
              ),
              sizedHeightBox(24),
              Align(
                alignment: Alignment.center,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8,
                  children: [
                    for (var index = 0; index < chips.length; index++)
                      ChoiceChip(
                        label: mainText(chips[index], 10),
                        selectedColor: CustomColors.PrimaryColor,
                        backgroundColor: CustomColors.ContainerBackgroundColor,
                        onSelected: (bool selected) {
                          setState(() {
                            indexes.contains(index)
                                ? indexes.remove(index)
                                : indexes.add(index);
                          });
                        },
                        selected: indexes.contains(index),
                      ),
                  ],
                ),
              ),
              sizedHeightBox(24),
              Form(
                key: _formKeyAbout,
                child: customInputTextField(
                  'О себе',
                  maxLine: 4,
                  text: true,
                  textEditingController: textAboutController,
                ),
              ),
              sizedHeightBox(24),
              Form(
                key: _formKeyExperience,
                child: customInputTextField(
                  'Опыт работы',
                  text: true,
                  textEditingController: textExperienceController,
                ),
              ),
              sizedHeightBox(24),
              Form(
                key: _formKeyEducation,
                child: customInputTextField(
                  'Образование',
                  text: true,
                  textEditingController: textEducationController,
                ),
              ),
              sizedHeightBox(24),
              Form(
                key: _formKeyWorkPlace,
                child: customInputTextField(
                  'Место работы',
                  text: true,
                  textEditingController: textWorkPlaceController,
                ),
              ),
              sizedHeightBox(80),
              customElevatedButton(context, 'Далее', onOk: () {
                if (!_formKeyAbout.currentState.validate()) return;
                if (!_formKeyExperience.currentState.validate()) return;
                if (!_formKeyEducation.currentState.validate()) return;
                if (!_formKeyWorkPlace.currentState.validate()) return;

                if (indexes.isEmpty) return;
                List<int> newChipsIndexes = indexes.map((e) => e + 1).toList();

                final profInfo = AuthRequestProfInfo(
                  workPlace: textWorkPlaceController.value.text,
                  education: textEducationController.value.text,
                  stacks: _stacksChosenValue,
                  skills: newChipsIndexes,
                  about: textAboutController.text,
                  workExperience: textExperienceController.text,
                  role: widget.role,
                );
                _authCubit.sendAuthProfInfo(profInfo);
              }),
              getBuilder(),
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
          if (state is AuthStacksResponseState) {
            stacksNotifier.value = state.categories;
          }
          if (state is AuthSkillsResponseState) {
            skillsNotifier.value = state.categories;
          }
          if (state is AuthErrorStepThreeState) {
            print("Error type +${state.status} + ${state.detail}");
            showAlert(context, "Ошибка", state.detail, () {});
          }
          if (state is AuthSuccessStepThreeState) {
            print("Success type +${state.status} + ${state.detail}");
            Navigator.of(context).pushNamed('/Step4', arguments: widget.role);
          }
        },
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

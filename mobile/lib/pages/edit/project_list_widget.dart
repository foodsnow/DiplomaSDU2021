import 'package:diploma_flutter_app/cubit/home/home_cubit.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/burn_models/burn.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectListWidget extends StatefulWidget {
  @override
  createState() => _ProjectListWidget();
}

class _ProjectListWidget extends State<ProjectListWidget> {
  final _scrollController = ScrollController();
  final List<Burn> _burns = [];

  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context)
      ..getAllBurnProjects()
      ..pageBurnList = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: BlocConsumer<HomeCubit, HomeCubitState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeInitialState ||
                state is HomeLoadingState && _burns.isEmpty) {
              return CircularProgressIndicator();
            }
            if (state is BurnProjectListSuccessState) {
              if (BlocProvider.of<HomeCubit>(context).pageBurnList == 1) {
                _burns.clear();
              }
              _burns.addAll(state.burns);
              BlocProvider.of<HomeCubit>(context).pageBurnList = 2;
              BlocProvider.of<HomeCubit>(context).isFetching = false;
            }
            if (state is BurnProjectListErrorState && _burns.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<HomeCubit>(context)
                        ..isFetching = true
                        ..pageBurnList = 1
                        ..getAllBurnProjects();
                    },
                    icon: Icon(Icons.refresh),
                  ),
                  const SizedBox(height: 15),
                  Text(state.details, textAlign: TextAlign.center),
                ],
              );
            }
            return ListView.separated(
              controller: _scrollController
                ..addListener(() {
                  if (_scrollController.offset ==
                          _scrollController.position.maxScrollExtent &&
                      !BlocProvider.of<HomeCubit>(context).isFetching) {
                    BlocProvider.of<HomeCubit>(context)
                      ..isFetching = true
                      ..getAllBurnProjects();
                  }
                }),
              itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: InkWell(
                          onLongPress: () {
                            showActionBottomSheet(context);
                          },
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/BurnOutDetailPage',
                              arguments: _burns[index].id,
                            );
                          },
                          child: Ink(
                            child: getProjectCardItem(_burns[index]),
                          )),
                    ),
                  ]),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: _burns.length,
            );
          },
        ),
      ),
    ]);
  }

  Widget getProjectCardItem(Burn burn) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mainText(burn.title, 14),
            sizedHeightBox(8),
            customText(burn.description, 12, CustomColors.MainTextColor,
                FontWeight.normal),
            sizedHeightBox(12),
            Row(
              children: [
                for (var i in burn.stacksId) getSkillsWidget(i.title),
              ],
            ),
            sizedHeightBox(8),
            Align(
              alignment: Alignment.centerRight,
              child: customText('до ${burn.deadline}', 10,
                  CustomColors.RedColor, FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

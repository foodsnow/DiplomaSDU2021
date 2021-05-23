import 'package:diploma_flutter_app/cubit/home/home_cubit.dart';
import 'package:diploma_flutter_app/pages/home/user_skills_item_widgets.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/developer.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/home/home_cubit.dart';

class FavoritesPage extends StatefulWidget {
  @override
  createState() => _FavoritesPage();
}

class _FavoritesPage extends State<FavoritesPage> {
  final _scrollController = ScrollController();
  final List<Developer> _developers = [];

  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context)
      ..getFavoritesDeveloperInfo()
      ..pageFavorites = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.White,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: ColoredBox(
              color: CustomColors.White,
              child: getBottomAppBar(),
            ),
          ),
        ),
        body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: BlocConsumer<HomeCubit, HomeCubitState>(
              listener: (context, state) {
                if (state is FavoritesDevInfoState) {
                  print("result info + ${state.developers}");
                }
              },
              builder: (context, state) {
                if (state is HomeInitialState ||
                    state is HomeLoadingState && _developers.isEmpty) {
                  return CircularProgressIndicator();
                }
                if (state is FavoritesDevInfoState) {
                  _developers.addAll(state.developers);
                  BlocProvider.of<HomeCubit>(context).pageFavorites = 2;
                  BlocProvider.of<HomeCubit>(context).isFetching = false;
                }
                if (state is FavoritesDevErrorState && _developers.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<HomeCubit>(context)
                            ..isFetching = true
                            ..getFavoritesDeveloperInfo();
                        },
                        icon: Icon(Icons.refresh),
                      ),
                      const SizedBox(height: 15),
                      Text(state.detail, textAlign: TextAlign.center),
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
                          ..getFavoritesDeveloperInfo();
                      }
                    }),
                  itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [_getUserItem(_developers[index])]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: _developers.length,
                );
              },
            ),
          ),
        ]));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _getUserItem(Developer item) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {
                isTokenExist().then((value) => {
                      if (value)
                        {
                          Navigator.pushNamed(context, '/AccountDetails',
                              arguments: item.id)
                        }
                      else
                        {
                          showAlert(context, "Ошибка",
                              "Пользователь не авторизован", () {})
                        }
                    });
              },
              child: Ink(
                child: UserSkillsItemWidget(
                  developer: item,
                ),
              )),
        ],
      ),
    );
  }

  Future<bool> isTokenExist() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null ? true : false;
  }

  Widget getBottomAppBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            'Избранные',
            style: TextStyle(
              fontSize: 22,
              color: CustomColors.MainTextColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        sizedHeightBox(16),
        Container(
          width: double.infinity,
          height: 8,
          color: CustomColors.ContainerBackgroundColor,
        ),
        sizedHeightBox(16),
      ],
    );
  }
}

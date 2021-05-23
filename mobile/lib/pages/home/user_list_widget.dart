import 'package:diploma_flutter_app/cubit/home/home_cubit.dart';
import 'package:diploma_flutter_app/pages/home/user_skills_item_widgets.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/developer.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserListWidget extends StatefulWidget {
  final int id;

  const UserListWidget(this.id);

  @override
  createState() => _UserListWidget();
}

class _UserListWidget extends State<UserListWidget> {
  final _scrollController = ScrollController();

  final List<Developer> _developers = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<HomeCubit, HomeCubitState>(
        listener: (context, state) {
          if (state is HomeSuccessInfoState) {
            print("result info + ${state.developers}");
          }
        },
        builder: (context, state) {
          if (state is HomeInitialState ||
              state is HomeLoadingState && _developers.isEmpty) {
            return CircularProgressIndicator();
          }
          if (state is HomeSuccessInfoState) {
            print("Page count + ${BlocProvider.of<HomeCubit>(context).page}");
            if (BlocProvider.of<HomeCubit>(context).page == 1) {
              _developers.clear();
            }
            _developers.addAll(state.developers);
            BlocProvider.of<HomeCubit>(context).page = 2;
            BlocProvider.of<HomeCubit>(context).isFetching = false;
          }
          if (state is HomeErrorState && _developers.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<HomeCubit>(context)
                      ..isFetching = true
                      ..fetchProfileInfo()
                      ..stacksId = widget.id;
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
                    ..fetchProfileInfo()
                    ..stacksId = widget.id;
                }
              }),
            itemBuilder: (context, index) => _getUserItem(_developers[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: _developers.length,
          );
        },
      ),
    );
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
}

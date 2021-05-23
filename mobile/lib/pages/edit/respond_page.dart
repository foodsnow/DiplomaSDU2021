import 'package:diploma_flutter_app/cubit/home/home_cubit.dart';
import 'package:diploma_flutter_app/pages/notification/accept_or_decline_items.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/burn_models/respond.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RespondPage extends StatefulWidget {
  const RespondPage({Key key}) : super(key: key);

  @override
  _RespondPageState createState() => _RespondPageState();
}

class _RespondPageState extends State<RespondPage> {
  final _scrollController = ScrollController();
  final List<Respond> _responds = [];

  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context)
      ..pageResponds = 1
      ..getAllRespondProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: BlocConsumer<HomeCubit, HomeCubitState>(
          listener: (context, state) {
            if (state is RespondListSuccessState) {
              print("result info + ${state.respond}");
            }
          },
          builder: (context, state) {
            if (state is HomeInitialState ||
                state is HomeLoadingState && _responds.isEmpty) {
              return CircularProgressIndicator();
            }
            if (state is RespondListSuccessState) {
              if (BlocProvider.of<HomeCubit>(context).pageResponds == 1) {
                _responds.clear();
              }
              _responds.addAll(state.respond);
              BlocProvider.of<HomeCubit>(context).pageResponds = 2;
              BlocProvider.of<HomeCubit>(context).isFetching = false;
            }
            if (state is RespondListErrorState && _responds.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<HomeCubit>(context)
                        ..isFetching = true
                        ..pageResponds = 1
                        ..getAllRespondProjects();
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
                      ..pageResponds = 1
                      ..getAllRespondProjects();
                  }
                }),
              itemBuilder: (context, index) =>
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: InkWell(
                      onTap: () {},
                      child: Ink(
                        child:
                            AcceptOrDeclineItemsPage(respond: _responds[index]),
                      )),
                ),
              ]),
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 2,
                decoration:
                    BoxDecoration(color: CustomColors.ContainerBackgroundColor),
              ),
              itemCount: _responds.length,
            );
          },
        ),
      ),
    ]);
  }
}

import 'package:diploma_flutter_app/pages/edit/project_list_widget.dart';
import 'package:diploma_flutter_app/pages/edit/respond_page.dart';
import 'package:diploma_flutter_app/pages/home/home_page.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BurnOutPage extends StatefulWidget {
  @override
  createState() => _BurnOutPage();
}

class _BurnOutPage extends State<BurnOutPage> with TickerProviderStateMixin {
  TabController _tabController;

  Future<bool> _isClientState;

  String firstTabBarName = 'Мои';

  @override
  void initState() {
    super.initState();
    _isClientState = isClient();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  get _tabBar => TabBar(
        controller: _tabController,
        tabs: [
          _getTabBarText(firstTabBarName, 0),
          _getTabBarText('Все', 1),
          _getTabBarText('Отклики', 2),
        ],
        indicator: CustomTabIndicator(),
        isScrollable: true,
        labelColor: CustomColors.White,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(6),
      );

  Tab _getTabBarText(String name, int index) {
    return Tab(
      child: customText(
          name,
          15,
          _tabController.index == index
              ? CustomColors.White
              : CustomColors.SecondaryTextColor,
          _tabController.index == index ? FontWeight.bold : FontWeight.w500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isClientState,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          firstTabBarName = snapshot.data ? 'Мои' : 'Рекомендации';
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              backgroundColor: CustomColors.White,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(100.0),
                child: ColoredBox(
                  color: CustomColors.White,
                  child: getBottomAppBar(_tabBar, 'Горячие проекты'),
                ),
              ),
            ),
            body: TabBarView(controller: _tabController, children: [
              snapshot.data
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        sizedHeightBox(33),
                        Image.asset("assets/images/no_data_image.png"),
                        sizedHeightBox(33),
                        mainText('У вас нет горячих проектов', 16),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 75, 0, 0),
                          child: customElevatedButton(context, 'Создать',
                              onOk: () {
                            Navigator.of(context).pushNamed(
                              '/CreateBurnOutPage',
                            );
                          }, edgeInsets: const EdgeInsets.all(8), width: null),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                      child: ProjectListWidget(),
                    ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: ProjectListWidget(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: RespondPage(),
              ),
            ]),
          );
        } else {
          return Text('asd');
        }
      },
    );
  }

  Future<bool> isClient() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('role') != null && prefs.getInt('role') == 1
        ? true
        : false;
  }
}

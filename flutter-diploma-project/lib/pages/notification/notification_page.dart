import 'package:diploma_flutter_app/pages/home/home_page.dart';
import 'package:diploma_flutter_app/pages/notification/accept_or_decline_items.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NotificationPage extends StatefulWidget {
  @override
  createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  get _tabBar => TabBar(
        controller: _tabController,
        tabs: [
          _getTabBarText('Все', 0),
          _getTabBarText('Отклики', 1),
          _getTabBarText('Подтвержденные', 2),
          _getTabBarText('Отказ', 3),
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
            child: getBottomAppBar(_tabBar, 'Уведомления'),
          ),
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        // Expanded(
        //   child: ListView.separated(
        //     shrinkWrap: true,
        //     itemCount: 20,
        //     itemBuilder: (ctx, int) {
        //       return InkWell(
        //           onTap: () {
        //             // Navigator.of(context).pushNamed(
        //             //   '/AccountDetails',
        //             //   arguments: 1,
        //             // );
        //           },
        //           child: Ink(
        //             child: AcceptOrDeclineItemsPage(),
        //           ));
        //     },
        //     separatorBuilder: (BuildContext context, int index) {
        //       return getItemDivider();
        //     },
        //   ),
        // ),
        Icon(Icons.notifications),
        Icon(Icons.notifications_active_outlined),
        Icon(Icons.notifications_paused),
        Icon(Icons.notifications_off),
      ]),
    );
  }
}

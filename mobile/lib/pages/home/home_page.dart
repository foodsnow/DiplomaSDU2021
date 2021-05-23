import 'package:diploma_flutter_app/cubit/home/home_cubit.dart';
import 'package:diploma_flutter_app/pages/home/filter_bottom_sheet.dart';
import 'package:diploma_flutter_app/pages/home/user_list_widget.dart';
import 'package:diploma_flutter_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Body();
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  TabController _tabController;

  TextEditingController controller;
  HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
        text: BlocProvider.of<HomeCubit>(context).searchKey);
    _tabController = TabController(length: 8, vsync: this);
    _tabController.addListener(_handleTabSelection);
    BlocProvider.of<HomeCubit>(context)
      ..fetchProfileInfo()
      ..page = 1
      ..searchKey = null;
  }

  void _handleTabSelection() {
    setState(() {});
  }

  get _tabBar => TabBar(
        controller: _tabController,
        tabs: [
          _getTabBarText('Все', 0),
          _getTabBarText('Backend', 1),
          _getTabBarText('Frontend', 2),
          _getTabBarText('Designer', 3),
          _getTabBarText('PM', 4),
          _getTabBarText('DS', 5),
          _getTabBarText('IOS', 6),
          _getTabBarText('Android', 7),
        ],
        onTap: (index) {
          BlocProvider.of<HomeCubit>(context)
            ..fetchProfileInfo()
            ..page = 1
            ..stacksId = index;
        },
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
    return DefaultTabController(
      length: 5,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            backgroundColor: CustomColors.White,
            title: getAppBarTitle(),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(118.0),
              child: ColoredBox(
                color: CustomColors.White,
                child: getBottomAppBar(),
              ),
            ),
            actions: [getFilterAction()],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: TabBarView(controller: _tabController, children: [
              for (var i = 0; i < 8; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserListWidget(i),
                  ],
                ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget getBottomAppBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            'Категория',
            style: TextStyle(
              fontSize: 17,
              color: CustomColors.MainTextColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        sizedHeightBox(10),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: _tabBar,
        ),
        sizedHeightBox(10),
        Container(
          width: double.infinity,
          height: 8,
          color: CustomColors.ContainerBackgroundColor,
        ),
      ],
    );
  }

  Widget getAppBarTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.ContainerBackgroundColor,
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: TextField(
          controller: controller,
          cursorColor: CustomColors.MainTextColor,
          style: TextStyle(color: CustomColors.MainTextColor),
          decoration: InputDecoration(
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
            print("Hello friends +${value}");
            BlocProvider.of<HomeCubit>(context)
              ..isFetching = true
              ..fetchProfileInfo()
              ..page = 1
              ..searchKey = value;
          },
        ),
      ),
    );
  }

  Widget getFilterAction() {
    return IconButton(
      icon: SvgPicture.asset('assets/icons/filter_icon.svg'),
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
              child: FilterBottomSheet(),
            ),
          ),
        );
      },
    );
  }
}

class CustomTabIndicator extends Decoration {
  @override
  _CustomPainter createBoxPainter([VoidCallback onChanged]) {
    return new _CustomPainter(this, onChanged);
  }
}

class _CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;

  _CustomPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    final Rect rect = offset & configuration.size;
    final Paint paint = Paint();
    paint.color = CustomColors.PrimaryColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(32.0)), paint);
  }
}

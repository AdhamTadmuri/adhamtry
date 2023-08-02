import 'package:flutter/material.dart';
import 'package:food_ordering_sp2/core/enums/bottom_navigation.dart';

import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_drawer.dart';
import 'package:food_ordering_sp2/ui/views/main_view/home_view/home_view.dart';
import 'package:food_ordering_sp2/ui/views/main_view/main_view_widgets/bottom_navigation_widget.dart';
import 'package:food_ordering_sp2/ui/views/main_view/menu_view/menu_view.dart';
import 'package:food_ordering_sp2/ui/views/main_view/more_view/more_view.dart';
import 'package:food_ordering_sp2/ui/views/main_view/offers_view/offers_view.dart';
import 'package:food_ordering_sp2/ui/views/main_view/profile_view/profile_view.dart';

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  BottomNavigationEnum selected = BottomNavigationEnum.HOME;
  PageController controller = PageController(initialPage: 2);

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: key,
        drawer: CustomDrawer(),
        bottomNavigationBar: BottomNavigationWidget(
          bottomNavigation: selected,
          onTap: (select, pageNumber) {},
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            MenuView(),
            OffersView(),
            HomeView(onPressed: () {
              key.currentState!.openDrawer();
            }),
            ProfileView(),
            MoreView()
          ],
        ),
      ),
    );
  }
}

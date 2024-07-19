import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/controller/views/reservation_screen_tab_controller.dart';
import '../../constants/text_constants.dart';

class ReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReservationScreenTabController>(
      init: ReservationScreenTabController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColourConstants.ghostWhite,
          body: SafeArea(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.menu_rounded,
                              color: ColourConstants.chineseBlack,
                              size: 30,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Manage Reservations',
                            style: TextConstants.mainTextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => TabBar(
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      controller: controller.tabController,
                      overlayColor: WidgetStateColor.resolveWith(
                          (_) => Colors.transparent),
                      tabs: <Widget>[
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            height: 60,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: controller.selectedIndex == 0
                                  ? ColourConstants.gamboge
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Tables',
                                style: TextConstants.subTextStyle(
                                  color: ColourConstants.chineseBlack,
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            height: 60,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: controller.selectedIndex == 1
                                  ? ColourConstants.gamboge
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                'Reservations',
                                style: TextConstants.subTextStyle(
                                  color: ColourConstants.chineseBlack,
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: const <Widget>[
                        Center(
                          child: Text("It's cloudy here"),
                        ),
                        Center(
                          child: Text("It's rainy here"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

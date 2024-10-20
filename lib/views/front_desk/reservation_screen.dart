import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/controller/views/drawer_state_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/reservation_screen_tab_controller.dart';
import 'package:restaurant_manager/components/custom_drawer.dart';
import 'package:restaurant_manager/views/front_desk/select_tables_tab_view.dart';
import 'package:restaurant_manager/views/front_desk/view_reservations_tab_view.dart';
import '../../constants/text_constants.dart';

class ReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_){
      DrawerStateController.instance.selectedIndex = DrawerStateController.RESERVATION_TILE_INDEX;
    });

    return GetBuilder<ReservationScreenTabController>(
      init: ReservationScreenTabController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            drawer: CustomDrawer(),
            backgroundColor: ColourConstants.white,
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 1));
                },
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Builder(
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                        child: Icon(
                                          Icons.menu_rounded,
                                          color: ColourConstants.chineseBlack,
                                          size: 30,
                                        ),
                                      );
                                    }
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
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Obx(
                              () => TabBar(
                                indicatorColor: Colors.transparent,
                                dividerColor: Colors.transparent,
                                controller: controller.tabController,
                                overlayColor: WidgetStateColor.resolveWith(
                                    (_) => Colors.transparent),
                                tabs: <Widget>[
                                  Tab(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      height: 60,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: controller.selectedIndex == 0
                                            ? ColourConstants.gamboge
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Tables',
                                          style: TextConstants.mainTextStyle(
                                            fontSize: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      height: 60,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: controller.selectedIndex == 1
                                            ? ColourConstants.gamboge
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Reservations',
                                          style: TextConstants.mainTextStyle(
                                            fontSize: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],

                              ),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: controller.tabController,
                              children: <Widget>[
                                SelectTablesTabView(),
                                ViewReservationsTabView(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

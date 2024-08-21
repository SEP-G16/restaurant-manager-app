import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/components/date_input_field.dart';
import 'package:restaurant_manager/components/loading_dialog.dart';
import 'package:restaurant_manager/components/reservation_tile.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_date_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/reservation_screen_tab_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/view_reservations_tab_view/view_reservations_date_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/view_reservations_tab_view/view_reservations_search_text_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/view_reservations_tab_view/view_reservations_tab_view_controller.dart';
import 'package:restaurant_manager/model/reservation.dart';
import 'package:restaurant_manager/model/restaurant_table.dart';
import 'package:restaurant_manager/views/front_desk/select_tables_tab_view.dart';
import '../../constants/text_constants.dart';

class ReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return GetBuilder<ReservationScreenTabController>(
      init: ReservationScreenTabController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
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
                                GetBuilder<ViewReservationsTabViewController>(
                                    init: ViewReservationsTabViewController(),
                                    builder: (mainCont) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 30),
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                          deviceSize.width *
                                                              0.4),
                                                  child: SearchAnchor(
                                                    builder:
                                                        (BuildContext context,
                                                            SearchController
                                                                controller) {
                                                      return GetBuilder<
                                                              ViewReservationsSearchTextController>(
                                                          init:
                                                              ViewReservationsSearchTextController(),
                                                          builder:
                                                              (searchCont) {
                                                            return SearchBar(
                                                              onChanged:
                                                                  (value) {
                                                                ViewReservationsTabViewController
                                                                    .instance
                                                                    .handleSearch(
                                                                        searchText:
                                                                            value);
                                                              },
                                                              controller:
                                                                  ViewReservationsTabViewController
                                                                      .instance
                                                                      .searchController,
                                                              hintText:
                                                                  'Search by Name or Phone Number',
                                                              hintStyle:
                                                                  WidgetStateTextStyle
                                                                      .resolveWith(
                                                                (_) => TextConstants
                                                                    .subTextStyle(
                                                                  fontSize: 16,
                                                                  color: ColourConstants
                                                                      .chineseBlack
                                                                      .withOpacity(
                                                                          0.7),
                                                                ),
                                                              ),
                                                              leading:
                                                                  IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: Icon(
                                                                  Icons.search,
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    suggestionsBuilder:
                                                        (BuildContext context,
                                                            SearchController
                                                                controller) {
                                                      return [];
                                                    },
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Filter by Date',
                                                      style: TextConstants
                                                          .subTextStyle(),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    GetBuilder<
                                                        ViewReservationsDateController>(
                                                      init:
                                                          ViewReservationsDateController(),
                                                      builder: (dateCont) {
                                                        return Obx(
                                                          () => DateInputField(
                                                            height: 50,
                                                            width: 200,
                                                            selectedDate: dateCont
                                                                .selectedDate,
                                                            onPressed:
                                                                () async {
                                                              DateTime now =
                                                                  DateTime
                                                                      .now();
                                                              DateTime
                                                                  twoWeekDate =
                                                                  now.add(Duration(
                                                                      days:
                                                                          14));

                                                              DateTime?
                                                                  selectedDate =
                                                                  await showDatePicker(
                                                                context:
                                                                    context,
                                                                firstDate: now,
                                                                lastDate:
                                                                    twoWeekDate,
                                                              );
                                                              dateCont.selectedDate =
                                                                  selectedDate ??
                                                                      now;

                                                              //TODO:Throw error if null
                                                              LoadingDialog(
                                                                callerFunction:
                                                                    () async {
                                                                  await mainCont
                                                                      .handleDateChange(
                                                                          selectedDate:
                                                                              selectedDate!);
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Obx(
                                                () => mainCont
                                                        .displayedReservations
                                                        .isEmpty
                                                    ? Center(
                                                        child: Text(
                                                          'Nothing to see here!', style: TextConstants.mainTextStyle(),
                                                        ),
                                                      )
                                                    : SingleChildScrollView(
                                                        child: Obx(
                                                          () => Column(
                                                            children: mainCont
                                                                .displayedReservations
                                                                .map(
                                                                  (reservation) =>
                                                                      ReservationTile(
                                                                    reservation:
                                                                        reservation,
                                                                    onCancelCallBack:
                                                                        () {},
                                                                  ),
                                                                )
                                                                .toList(),
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
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

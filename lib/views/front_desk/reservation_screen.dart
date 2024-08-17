import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/components/date_input_field.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/reservation_screen_date_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/reservation_screen_drop_down_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/reservation_screen_tab_controller.dart';
import '../../constants/text_constants.dart';

class ReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReservationScreenTabController>(
      init: ReservationScreenTabController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColourConstants.white,
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
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 20.0,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              GetBuilder<ReservationScreenDropDownController>(
                                  init: ReservationScreenDropDownController(),
                                  builder: (dropDownCont) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '# of Chairs',
                                              style:
                                                  TextConstants.subTextStyle(),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 4,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Obx(
                                                () => DropdownButton(
                                                    iconEnabledColor:
                                                        ColourConstants
                                                            .chineseBlack,
                                                    value: dropDownCont
                                                        .selectedCount,
                                                    underline: Container(),
                                                    items: dropDownCont
                                                        .chairCountList
                                                        .map<DropdownMenuItem>(
                                                          (count) =>
                                                              DropdownMenuItem(
                                                            value: count,
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 60,
                                                              child: Text(
                                                                count
                                                                    .toString(),
                                                                style: TextConstants
                                                                    .subTextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (value) {
                                                      dropDownCont
                                                              .selectedCount =
                                                          value;
                                                    }),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Date',
                                              style:
                                                  TextConstants.subTextStyle(),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            GetBuilder<
                                                ReservationScreenDateController>(
                                              init:
                                                  ReservationScreenDateController(),
                                              builder: (dateCont) {
                                                return Obx(
                                                  () => DateInputField(
                                                    height: 50,
                                                    width: 200,
                                                    selectedDate:
                                                        dateCont.selectedDate,
                                                    onPressed: () async {
                                                      DateTime now =
                                                          DateTime.now();
                                                      DateTime twoWeekDate =
                                                          now.add(Duration(
                                                              days: 14));

                                                      DateTime? selectedDate =
                                                          await showDatePicker(
                                                              context: context,
                                                              firstDate:
                                                                  now.hour >= 22
                                                                      ? now.add(
                                                                          Duration(
                                                                            days:
                                                                                1,
                                                                          ),
                                                                        )
                                                                      : now,
                                                              lastDate: now
                                                                          .hour >=
                                                                      22
                                                                  ? twoWeekDate
                                                                      .add(
                                                                      Duration(
                                                                        days: 1,
                                                                      ),
                                                                    )
                                                                  : twoWeekDate);
                                                      dateCont.selectedDate =
                                                          selectedDate ?? now;
                                                    },
                                                  ),
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Time Slot',
                                              style:
                                                  TextConstants.subTextStyle(),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 4,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Obx(
                                                () => DropdownButton(
                                                    iconEnabledColor:
                                                        ColourConstants
                                                            .chineseBlack,
                                                    value: dropDownCont
                                                        .selectedTimeSlot,
                                                    underline: Container(),
                                                    items: dropDownCont
                                                        .timeSlots
                                                        .map<DropdownMenuItem>(
                                                          (timeSlot) =>
                                                              DropdownMenuItem(
                                                            value: timeSlot,
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 150,
                                                              child: Text(
                                                                timeSlot,
                                                                style: TextConstants
                                                                    .subTextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (value) {
                                                      dropDownCont
                                                              .selectedTimeSlot =
                                                          value;
                                                    }),
                                              ),
                                            ),
                                            // DropdownButton(items: items, onChanged: (value){})
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                      10,
                                      (_) => Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                        ),
                                        color: Colors.amberAccent,
                                        width: 150,
                                        height: 60,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
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

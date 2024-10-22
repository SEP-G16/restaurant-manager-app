import 'package:flutter/material.dart';
import 'package:restaurant_manager/components/message_dialog_box.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_screen/add_reservation_screen_state_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_controller.dart';

import '../../components/action_button.dart';
import '../../components/date_input_field.dart';
import '../../components/table_tile.dart';
import '../../constants/colour_constants.dart';
import '../../constants/text_constants.dart';

import 'package:get/get.dart';

import '../../controller/data/reservation_screen/add_reservation_tab_view_data_controller.dart';
import '../../controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_date_controller.dart';
import '../../controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_drop_down_controller.dart';
import 'add_reservation_screen.dart';

class SelectTablesTabView extends StatelessWidget {
  const SelectTablesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 20.0,
      ),
      alignment: Alignment.center,
      child: Column(
        //TODO: fix width issue
        children: [
          GetBuilder<AddReservationTabViewDropDownController>(
            // init: AddReservationTabViewDropDownController(),
            builder: (dropDownCont) {
              return orientation == Orientation.landscape
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '# of Chairs',
                              style: TextConstants.mainTextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                              child: Obx(
                                () => DropdownButton(
                                    iconEnabledColor:
                                        ColourConstants.chineseBlack,
                                    value: dropDownCont.selectedCount,
                                    underline: Container(),
                                    items: dropDownCont.chairCountList
                                        .map<DropdownMenuItem>(
                                          (count) => DropdownMenuItem(
                                            value: count,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 60,
                                              child: Text(
                                                count == -1
                                                    ? 'All'
                                                    : count.toString(),
                                                style: TextConstants
                                                    .subTextStyle(),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      dropDownCont.selectedCount = value;
                                      //
                                      // //change table data as well
                                      // AddReservationTabViewController.instance
                                      //     .changeDisplayedTables(value);
                                    }),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Date',
                              style: TextConstants.mainTextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            GetBuilder<AddReservationTabViewDateController>(
                              // init: AddReservationTabViewDateController(),
                              builder: (dateCont) {
                                return Obx(
                                  () => DateInputField(
                                    height: 50,
                                    width: 200,
                                    selectedDate: dateCont.selectedDate,
                                    onPressed: () async {
                                      DateTime now = DateTime.now();
                                      DateTime twoWeekDate =
                                          now.add(Duration(days: 14));

                                      if (now.hour >= 20) {
                                        now = now.add(
                                          Duration(
                                            days: 1,
                                          ),
                                        );
                                        twoWeekDate = twoWeekDate.add(
                                          Duration(
                                            days: 1,
                                          ),
                                        );
                                      }

                                      DateTime? selectedDate =
                                          await showDatePicker(
                                        context: context,
                                        firstDate: now,
                                        lastDate: twoWeekDate,
                                      );
                                      if (selectedDate == null) {
                                        MessageDialogBox(
                                          message: 'Please select a date',
                                          btnOnPressed: () {
                                            Get.back();
                                          },
                                        );
                                      } else {
                                        if (selectedDate.day ==
                                            DateTime.now().day) {
                                          dateCont.selectedDate =
                                              DateTime.now();
                                        } else {
                                          dateCont.selectedDate = selectedDate;

                                        }
                                      }
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
                              style: TextConstants.mainTextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                              child: Obx(
                                () => DropdownButton(
                                    iconEnabledColor:
                                        ColourConstants.chineseBlack,
                                    value: dropDownCont.selectedTimeSlot,
                                    underline: Container(),
                                    items: dropDownCont.timeSlots
                                        .map<DropdownMenuItem>(
                                          (timeSlot) => DropdownMenuItem(
                                            value: timeSlot,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 150,
                                              child: Text(
                                                timeSlot,
                                                style: TextConstants
                                                    .subTextStyle(),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      dropDownCont.selectedTimeSlot = value;
                                    }),
                              ),
                            ),
                            // DropdownButton(items: items, onChanged: (value){})
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '# of Chairs',
                                  style:
                                      TextConstants.mainTextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                  child: Obx(
                                    () => DropdownButton(
                                        iconEnabledColor:
                                            ColourConstants.chineseBlack,
                                        value: dropDownCont.selectedCount,
                                        underline: Container(),
                                        items: dropDownCont.chairCountList
                                            .map<DropdownMenuItem>(
                                              (count) => DropdownMenuItem(
                                                value: count,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 60,
                                                  child: Text(
                                                    count == -1
                                                        ? 'All'
                                                        : count.toString(),
                                                    style: TextConstants
                                                        .subTextStyle(),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          dropDownCont.selectedCount = value;

                                          //change table data as well
                                          // AddReservationTabViewController
                                          //     .instance
                                          //     .changeDisplayedTables(value);
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
                                      TextConstants.mainTextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                GetBuilder<AddReservationTabViewDateController>(
                                  // init: AddReservationTabViewDateController(),
                                  builder: (dateCont) {
                                    return Obx(
                                      () => DateInputField(
                                        height: 50,
                                        width: 200,
                                        selectedDate: dateCont.selectedDate,
                                        onPressed: () async {
                                          DateTime now = DateTime.now();
                                          DateTime twoWeekDate =
                                              now.add(Duration(days: 14));

                                          if (now.hour >= 20) {
                                            now = now.add(
                                              Duration(
                                                days: 1,
                                              ),
                                            );
                                            twoWeekDate = twoWeekDate.add(
                                              Duration(
                                                days: 1,
                                              ),
                                            );
                                          }

                                          DateTime? selectedDate =
                                              await showDatePicker(
                                            context: context,
                                            firstDate: now,
                                            lastDate: twoWeekDate,
                                          );
                                          if (selectedDate == null) {
                                            MessageDialogBox(
                                              message: 'Please select a date',
                                              btnOnPressed: () {
                                                Get.back();
                                              },
                                            );
                                          } else {
                                            if (selectedDate.day ==
                                                DateTime.now().day) {
                                              dateCont.selectedDate =
                                                  DateTime.now();
                                            } else {
                                              dateCont.selectedDate = selectedDate;

                                            }
                                          }
                                        },
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Time Slot',
                              style: TextConstants.mainTextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                              child: Obx(
                                () => DropdownButton(
                                    iconEnabledColor:
                                        ColourConstants.chineseBlack,
                                    value: dropDownCont.selectedTimeSlot,
                                    underline: Container(),
                                    items: dropDownCont.timeSlots
                                        .map<DropdownMenuItem>(
                                          (timeSlot) => DropdownMenuItem(
                                            value: timeSlot,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 150,
                                              child: Text(
                                                timeSlot,
                                                style: TextConstants
                                                    .subTextStyle(),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      dropDownCont.selectedTimeSlot = value;
                                    }),
                              ),
                            ),
                            // DropdownButton(items: items, onChanged: (value){})
                          ],
                        ),
                      ],
                    );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Select Tables to Reserve',
              style: TextConstants.mainTextStyle(),
            ),
          ),
          Expanded(
            child: Obx(
              () => AddReservationTabViewController
                      .instance.displayedTables.isNotEmpty
                  ? Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: AddReservationTabViewController
                                .instance.displayedTables
                                .map((table) {
                              return TableTile(
                                selectMode: true,
                                table: table,
                                //passing controller check value
                                checkValue: AddReservationTabViewController
                                    .instance
                                    .checkTableSelected(id: table.id),

                                //changing state
                                onCheckBoxPressed: (value) {
                                  // add table to selected if checked
                                  print(value);
                                  if (value == true) {
                                    AddReservationTabViewController.instance
                                        .addOrRemoveSelectedTable(id: table.id);
                                  }
                                  //otherwise remove
                                  else {
                                    AddReservationTabViewController.instance
                                        .addOrRemoveSelectedTable(
                                            id: table.id, remove: true);
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        Visibility(
                          visible: AddReservationTabViewController
                              .instance.selectedTables.isNotEmpty,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ActionButton(
                                btnText: 'Add Reservation',
                                onTap: () async {

                                  if(AddReservationTabViewDropDownController.instance.isTimeSlotBeforeCurrentHour(AddReservationTabViewDropDownController.instance.selectedTimeSlot))
                                    {
                                      MessageDialogBox(
                                        message: 'Please select a valid time slot',
                                        btnOnPressed: () {
                                          Get.back();
                                        },
                                      );
                                      return;
                                    }

                                  await Future.delayed(
                                    Duration(
                                      milliseconds: 300,
                                    ),
                                  );

                                  final stateCont = AddReservationScreenStateController.instance;
                                  stateCont.resetController();
                                  stateCont.selectedDate = AddReservationTabViewDateController.instance.selectedDate;
                                  stateCont.timeSlot = AddReservationTabViewDropDownController.instance.selectedTimeSlot;
                                  Get.to(() => AddReservationScreen());
                                },
                                width: 300,
                              )),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sorry, There are no tables available',
                          style: TextConstants.mainTextStyle(),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/components/loading_dialog.dart';
import 'package:restaurant_manager/components/message_dialog_box.dart';
import 'package:restaurant_manager/components/named_input_field.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_screen/add_reservation_screen_state_controller.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_controller.dart';
import 'package:restaurant_manager/model/form_valid_response.dart';

import '../../constants/text_constants.dart';

import 'package:get/get.dart';

class AddReservationScreen extends StatelessWidget {
  AddReservationScreen({super.key});

  final stateCont = AddReservationScreenStateController.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ColourConstants.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: ColourConstants.chineseBlack,
                          size: 30,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Add Reservation',
                        style: TextConstants.mainTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Customer Details',
                                  style:
                                      TextConstants.mainTextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: NamedInputField(
                                    titleText: 'First Name',
                                    onChanged: (value) {
                                      stateCont.firstName = value;
                                    },
                                    width: double.maxFinite,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Expanded(
                                  child: NamedInputField(
                                    titleText: 'Last Name',
                                    onChanged: (value) {
                                      stateCont.firstName = value;
                                    },
                                    width: double.maxFinite,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: NamedInputField(
                                    titleText: 'Phone No.',
                                    keyboardType: TextInputType.phone,
                                    onChanged: (value) {
                                      stateCont.phoneNo = value;
                                    },
                                    width: double.maxFinite,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Expanded(
                                  child: NamedInputField(
                                    titleText: 'Email',
                                    onChanged: (value) {
                                      stateCont.email = value;
                                    },
                                    width: double.maxFinite,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      //TODO : Autofill selected data
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Reservation Details',
                                  style:
                                      TextConstants.mainTextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: NamedInputField(
                                    titleText: 'Date',
                                    readOnly: true,
                                    initialValue: DateFormat('yyyy/MM/dd')
                                        .format(stateCont.selectedDate),
                                    onChanged: (value) {},
                                    width: double.maxFinite,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Expanded(
                                  child: NamedInputField(
                                    titleText: 'Time',
                                    readOnly: true,
                                    initialValue: stateCont.timeSlot,
                                    onChanged: (value) {},
                                    width: double.maxFinite,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: NamedInputField(
                                    titleText: 'Number of Customers',
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      stateCont.peopleCount = int.parse(value!);
                                    },
                                    width: double.maxFinite,
                                  ),
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                Expanded(child: SizedBox()),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ActionButton(
                        btnText: 'Complete Reservation',
                        onTap: () async {
                          FormValidResponse response = stateCont.validateForm();
                          if (!response.formValid) {
                            MessageDialogBox(
                                message: response.message!,
                                btnOnPressed: () {
                                  Get.back();
                                });
                          } else {
                            LoadingDialog(
                              callerFunction: () async {
                                await stateCont.addReservation();
                              },
                              onErrorCallBack: (error) {
                                MessageDialogBox(
                                    message: error.toString(),
                                    btnOnPressed: () {
                                      Get.back();
                                    });
                              },
                            );
                            Get.back();
                          }
                          //TODO: validate form
                        },
                        width: 400,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

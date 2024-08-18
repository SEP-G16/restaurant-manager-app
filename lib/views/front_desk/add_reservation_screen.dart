import 'package:flutter/material.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/components/named_input_field.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/controller/data/reservation_screen/reservation_screen_data_controller.dart';

import '../../constants/text_constants.dart';

import 'package:get/get.dart';

class AddReservationScreen extends StatelessWidget {
  const AddReservationScreen({super.key});

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
                                    onChanged: (value) {},
                                    width: double.maxFinite,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Expanded(
                                  child: NamedInputField(
                                    titleText: 'Last Name',
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
                                    titleText: 'Phone No.',
                                    onChanged: (value) {},
                                    width: double.maxFinite,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Expanded(
                                  child: NamedInputField(
                                    titleText: 'Email',
                                    onChanged: (value) {},
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
                                    onChanged: (value) {},
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
                        onTap: () {

                          //TODO: validate form
                          final reservationDataCont = ReservationScreenDataController.instance;
                          reservationDataCont.reInit();
                          Get.back();
                        },
                        width: 400,
                      ),
                      SizedBox(height: 30,),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/constants/text_constants.dart';
import 'package:restaurant_manager/views/front_desk/reservation_screen.dart';
import 'package:restaurant_manager/views/kitchen/inventory_management_screen.dart';
import 'package:restaurant_manager/views/kitchen_staff/order/order_main_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: OrientationBuilder(builder: (context, orientation) {
        return Container(
          padding: EdgeInsets.all(20.0),
          width: orientation == Orientation.landscape
              ? deviceWidth * 0.33
              : deviceWidth * 0.4,
          color: Colors.white,
          child: Column(
            children: [
              Text(
                'Manage Restaurant',
                style: TextConstants.mainTextStyle(),
              ),
              SizedBox(height: 20,),
              ActionButton(
                btnText: 'Manage Reservations',
                onTap: () {
                  Get.offAll(() => ReservationScreen());
                },
                width: 250,
              ),
              SizedBox(height: 15,),
              ActionButton(
                btnText: 'Manage Orders',
                onTap: () {
                  Get.offAll(() => OrderMainScreen());
                },
                width: 250,
              ),
              SizedBox(height: 15,),
              ActionButton(
                btnText: 'Manage Inventory',
                onTap: () {
                  Get.offAll(() => InventoryManagementScreen());
                },
                width: 250,
              ),
            ],
          ),
        );
      }),
    );
  }
}

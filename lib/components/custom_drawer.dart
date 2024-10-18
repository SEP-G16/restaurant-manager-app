import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/constants/svg_constants.dart';
import 'package:restaurant_manager/constants/text_constants.dart';
import 'package:restaurant_manager/controller/views/drawer_state_controller.dart';
import 'package:restaurant_manager/views/front_desk/reservation_screen.dart';
import 'package:restaurant_manager/views/kitchen/inventory_management_screen.dart';
import 'package:restaurant_manager/views/kitchen_staff/order/order_main_screen.dart';
import 'package:restaurant_manager/views/payment_screen.dart';
import 'package:restaurant_manager/views/table_management_screen.dart';

import '../constants/colour_constants.dart';
import '../controller/data/auth_controller.dart';

import 'package:restaurant_manager/enum/role.dart';

class DrawerTile extends StatelessWidget {
  DrawerTile({
    this.icon = Icons.dashboard,
    this.title = 'Dashboard',
    this.colour = ColourConstants.gamboge,
    this.textColour = ColourConstants.white,
    this.onPressed,
  });

  IconData icon;
  String title;
  Color colour;
  Color textColour;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: colour,
        height: 70,
        child: Row(
          children: [
            Icon(
              icon,
              color: textColour,
              size: 28,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextConstants.subTextStyle(color: textColour),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DrawerStateController());
    double displayWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Builder(builder: (context) {
        return Container(
          color: Colors.white,
          width: displayWidth * 0.3,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: Column(
            children: [
              SvgPicture.string(
                SvgConstants.loginCoverImage,
                height: 150,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Welcome',
                style: TextConstants.mainTextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: AuthController.instance.hasRole([
                  Role.ROLE_ADMIN,
                  Role.ROLE_FRONT_DESK,
                  Role.ROLE_RESTAURANT_MANAGER
                ]),
                child: Builder(
                  builder: (context) {
                    return Obx(() {
                      bool isSelected =
                          DrawerStateController.instance.selectedIndex == 0;
                      return DrawerTile(
                        title: 'Reservations',
                        icon: Icons.bookmark_outline_outlined,
                        colour: isSelected
                            ? ColourConstants.gamboge
                            : Colors.grey.shade100,
                        textColour: isSelected
                            ? ColourConstants.white
                            : ColourConstants.chineseBlack,
                        onPressed: () {
                          DrawerStateController.instance.selectedIndex = 0;
                          Scaffold.of(context).closeDrawer();
                          Get.to(() => ReservationScreen());
                        },
                      );
                    });
                  }
                ),
              ),

              Visibility(
                visible: AuthController.instance.hasRole([Role.ROLE_ADMIN, Role.ROLE_CHEF]),
                child: Obx(() {
                  bool isSelected =
                      DrawerStateController.instance.selectedIndex == 1;
                  return DrawerTile(
                    icon: Icons.fastfood_outlined,
                    title: 'Orders',
                    colour: isSelected
                        ? ColourConstants.gamboge
                        : Colors.grey.shade100,
                    textColour: isSelected
                        ? ColourConstants.white
                        : ColourConstants.chineseBlack,
                    onPressed: () {
                      DrawerStateController.instance.selectedIndex = 1;
                      Scaffold.of(context).closeDrawer();
                      Get.to(() => OrderMainScreen());
                    },
                  );
                }),
              ),
              Visibility(
                visible: AuthController.instance.hasRole([
                  Role.ROLE_ADMIN,
                  Role.ROLE_RESTAURANT_MANAGER,
                  Role.ROLE_CHEF
                ]),
                child: Obx(() {
                  bool isSelected =
                      DrawerStateController.instance.selectedIndex == 2;
                  return DrawerTile(
                    icon: Icons.inventory_2_outlined,
                    title: 'Inventory',
                    colour: isSelected
                        ? ColourConstants.gamboge
                        : Colors.grey.shade100,
                    textColour: isSelected
                        ? ColourConstants.white
                        : ColourConstants.chineseBlack,
                    onPressed: () {
                      DrawerStateController.instance.selectedIndex = 2;
                      Get.to(() => InventoryManagementScreen());
                    },
                  );
                }),
              ),

              Visibility(
                visible: AuthController.instance.hasRole([
                  Role.ROLE_ADMIN,
                  Role.ROLE_FRONT_DESK,
                  Role.ROLE_RESTAURANT_MANAGER
                ]),
                child: Obx(() {
                  bool isSelected =
                      DrawerStateController.instance.selectedIndex == 3;
                  return DrawerTile(
                    icon: Icons.table_restaurant_outlined,
                    title: 'Tables',
                    colour: isSelected
                        ? ColourConstants.gamboge
                        : Colors.grey.shade100,
                    textColour: isSelected
                        ? ColourConstants.white
                        : ColourConstants.chineseBlack,
                    onPressed: () {
                      DrawerStateController.instance.selectedIndex = 3;
                      Get.to(() => TableManagementScreen());
                    },
                  );
                }),
              ),

              Visibility(
                visible: AuthController.instance.hasRole([
                  Role.ROLE_ADMIN,
                  Role.ROLE_FRONT_DESK,
                  Role.ROLE_RESTAURANT_MANAGER
                ]),
                child: Obx(() {
                  bool isSelected =
                      DrawerStateController.instance.selectedIndex == 5;
                  return DrawerTile(
                    icon: Icons.payments_outlined,
                    title: 'Payment',
                    colour: isSelected
                        ? ColourConstants.gamboge
                        : Colors.grey.shade100,
                    textColour: isSelected
                        ? ColourConstants.white
                        : ColourConstants.chineseBlack,
                    onPressed: () {
                      DrawerStateController.instance.selectedIndex = 5;
                      Get.to(() => PaymentScreen());
                    },
                  );
                }),
              ),
              Spacer(),
              ActionButton(
                  btnText: 'Logout',
                  onTap: () async {
                    await AuthController.instance.logout();
                  }),
            ],
          ),
        );
      }),
    );
  }
}

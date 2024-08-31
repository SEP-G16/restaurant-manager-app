import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/components/custom_drop_down_button.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/constants/text_constants.dart';
import 'package:restaurant_manager/controller/views/inventory_controller.dart';
import 'package:restaurant_manager/views/exclude_custom_drawer.dart';
import 'package:restaurant_manager/views/kitchen/view_inventory.dart';

class InventoryManagementScreen extends StatelessWidget {
  final InventoryController inventoryController =
      Get.find<InventoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Builder(builder: (context) {
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
                    }),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Manage Inventory',
                      style: TextConstants.mainTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Here',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // Add search functionality if needed
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  'Availability',
                  style: TextConstants.subTextStyle(),
                ),
                SizedBox(
                  width: 20,
                ),
                CustomDropDownButton(
                  value: 'In Stock',
                  selectOptionValue: 'All',
                  onChanged: (value) {},
                  itemList: [
                    DropdownMenuItem(
                      child: Text('In Stock'),
                      value: 'In Stock',
                    ),
                  ],
                  width: 300,
                ),
              ],
            ),
            // Button to navigate to ViewInventoryScreen
            // Inventory Items List
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: inventoryController.inventory
                      .map(
                        (item) => Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: ColourConstants.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.fastfood_rounded),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    item.name,
                                    style: TextConstants.mainTextStyle(
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ActionButton(
                                    btnText: 'Mark as Out of Stock',
                                    onTap: () {
                                      inventoryController
                                          .markAsOutOfStock(item.name);
                                    },
                                    outlineMode: true,
                                    borderWidth: 2.0,
                                    borderColour: ColourConstants.red,
                                    outlineModeHoverColour:
                                        ColourConstants.red.withOpacity(0.1),
                                    width: 180,
                                    fontSize: 16,
                                    height: 40,
                                  ),
                                  SizedBox(width: 10.0),
                                  ActionButton(
                                    btnText: 'Mark as In Stock',
                                    onTap: () {
                                      inventoryController
                                          .markAsInStock(item.name);
                                    },
                                    outlineMode: true,
                                    borderWidth: 2.0,
                                    borderColour: ColourConstants.green,
                                    outlineModeHoverColour:
                                        ColourConstants.green.withOpacity(0.1),
                                    width: 180,
                                    fontSize: 16,
                                    height: 40,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Get.to(() => ViewInventoryScreen());
            //   },
            //   child: Text(
            //     'View Inventory',
            //     style: TextStyle(
            //       fontSize: 20, // Set the desired text size
            //       color: ColourConstants.gamboge, // Adjust text color if needed
            //     ),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: ColourConstants.white,
            //     minimumSize: Size(200, 60),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

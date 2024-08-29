import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/constants/text_constants.dart';
import 'package:restaurant_manager/controller/views/inventory_controller.dart';

import '../front_desk/add_reservation_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/views/kitchen/view_inventory.dart';


class InventoryManagementScreen extends StatelessWidget {
  final InventoryController inventoryController = Get.find<InventoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColourConstants.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColourConstants.chineseBlack),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Inventory Management',
          style: TextStyle(fontSize: 24, color: ColourConstants.chineseBlack),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
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
            // Button to navigate to ViewInventoryScreen
            // Inventory Items List
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: inventoryController.inventory.length,
                  itemBuilder: (context, index) {
                    final item = inventoryController.inventory[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                        item.name,
                        style: TextConstants.mainTextStyle(fontSize: 20),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ActionButton(
                            btnText: 'Mark as Out of Stock',
                            onTap: () {
                              inventoryController.markAsOutOfStock(item.name);
                            },
                            outlineMode: true,
                            borderWidth: 2.0,
                            borderColour: ColourConstants.red,
                            width: 180,
                            fontSize: 16,),
                          SizedBox(width: 10.0),
                          ActionButton(
                            btnText: 'Mark as In Stock',
                            onTap: () {
                              inventoryController.markAsInStock(item.name);
                            },
                            outlineMode: true,
                            borderWidth: 2.0,
                            borderColour: ColourConstants.green,
                            width: 180,
                            fontSize: 16,),
                        ],
                      ),
                      ]
                    )
                    );
                  },
                );
              }),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => ViewInventoryScreen());
              },
              child: Text('View Inventory',
                style: TextStyle(
                  fontSize: 20, // Set the desired text size
                  color: ColourConstants.gamboge, // Adjust text color if needed
                ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColourConstants.white,
                minimumSize: Size(200, 60),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
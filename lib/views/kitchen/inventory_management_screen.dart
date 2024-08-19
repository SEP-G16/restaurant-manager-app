import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/constants/text_constants.dart';

import '../front_desk/add_reservation_screen.dart';

class InventoryManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColourConstants.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColourConstants.blue),
          onPressed: () {
            // handle back navigation
          },
        ),
        title: Text(
          'Inventory Management',
          style: TextConstants.mainTextStyle(fontSize: 24),
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
                      // mention where to go on press action
                    },
                  ),
                ],
              ),
            ),
            // Inventory Items List
            Expanded(
              child: ListView(
                children: [
                  // First Tile
                  _buildInventoryTile('Chicken Bun'),
                  SizedBox(height: 10.0),
                  // Second Tile
                  _buildInventoryTile('Chicken Dumpling'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryTile(String itemName) {
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
            itemName,
            style: TextConstants.mainTextStyle(fontSize: 20),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ActionButton(
                btnText: 'Mark as Out of Stock',
                onTap: () {
                  Get.to(() =>
                      AddReservationScreen());
                  // direct this to add reservation page just for testing
                },
                btnColor: Colors.white,
                textColor: Colors.red,
                borderColor: Colors.red,
                width: 180,
                fontSize: 16,
              ),
              SizedBox(width: 10.0),
              ActionButton(
                btnText: 'Mark as In Stock',
                onTap: () {
                  // Handle in stock action
                },
                btnColor: Colors.white,
                textColor: Colors.green,
                borderColor: Colors.green,
                width: 180,
                fontSize: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

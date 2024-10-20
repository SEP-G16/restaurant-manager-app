import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/components/custom_drop_down_button.dart';
import 'package:restaurant_manager/components/inventory_tile.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/constants/text_constants.dart';
import 'package:restaurant_manager/controller/views/view_inventory_screen/inventory_screen_state_controller.dart';
import 'package:restaurant_manager/enum/menu_item_status.dart';
import 'package:restaurant_manager/components/custom_drawer.dart';

import '../../controller/views/drawer_state_controller.dart';


class InventoryManagementScreen extends StatelessWidget {
  final InventoryScreenStateController inventoryController =
      InventoryScreenStateController.instance;

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_){
      DrawerStateController.instance.selectedIndex = DrawerStateController.INVENTORY_TILE_INDEX;
    });


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
                Obx(
                  () => CustomDropDownButton(
                    value: inventoryController.selectedDropDownOption,
                    selectOptionValue: 'All',
                    selectOptionText: 'All',
                    onChanged: (value) {
                      inventoryController.selectedDropDownOption = value;
                    },
                    itemList: [
                      DropdownMenuItem(
                        child: Text('In Stock'),
                        value: 'In Stock',
                      ),
                      DropdownMenuItem(
                        child: Text('Out of Stock'),
                        value: 'Out of Stock',
                      ),
                    ],
                    width: 300,
                  ),
                ),
              ],
            ),
            // Button to navigate to ViewInventoryScreen
            // Inventory Items List
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: inventoryController.displayedInventoryList
                        .map(
                          (item) => InventoryTile(
                            item: item,
                            onMarkAsInStockPressed: () async {
                              await inventoryController.updateStockStatus(
                                  itemId: item.id, status: MenuItemStatus.InStock);
                            },
                            onMarkAsOutOfStockPressed: () async {
                              await inventoryController.updateStockStatus(
                                  itemId: item.id, status: MenuItemStatus.OutOfStock);
                            },
                            onErrorCallBack: (error) {
                              Get.snackbar('Error', error.toString());
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
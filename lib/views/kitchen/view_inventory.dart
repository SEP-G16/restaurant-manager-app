import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/components/date_input_field.dart';
import 'package:restaurant_manager/components/table_tile.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import '../../constants/text_constants.dart';
import 'package:restaurant_manager/controller/views/view_inventory_screen/view_inventory_screen_tab_controller.dart';
import 'package:restaurant_manager/controller/views/inventory_controller.dart';

class ViewInventoryScreen extends StatelessWidget {
  final InventoryController inventoryController = Get.find<InventoryController>();
  final ViewInventoryScreenTabController tabController = Get.put(ViewInventoryScreenTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColourConstants.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColourConstants.blue),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'View Inventory',
          style: TextStyle(fontSize: 24, color: ColourConstants.chineseBlack),
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Obx(() => TabBar(
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              overlayColor: WidgetStateColor.resolveWith(
                      (_) => Colors.transparent),
              tabs: [
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 40,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: tabController.selectedIndex.value == 0
                          ? ColourConstants.green
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'In Stock',
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
                      color: tabController.selectedIndex.value == 1
                          ? ColourConstants.red
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Out of Stock',
                        style: TextConstants.subTextStyle(
                          color: ColourConstants.chineseBlack,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              onTap: (index) {
                tabController.selectedIndex.value = index;
              },
            )),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() {
                    var inStockItems = inventoryController.inventory
                        .where((item) => item.isInStock)
                        .toList();
                    return ListView.builder(
                      itemCount: inStockItems.length,
                      itemBuilder: (context, index) {
                        final item = inStockItems[index];
                        return _buildViewInventoryTile(item.name);
                      },
                    );
                  }),
                  Obx(() {
                    var outOfStockItems = inventoryController.inventory
                        .where((item) => !item.isInStock)
                        .toList();
                    return ListView.builder(
                      itemCount: outOfStockItems.length,
                      itemBuilder: (context, index) {
                        final item = outOfStockItems[index];
                        return _buildViewInventoryTile(item.name);
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildViewInventoryTile(String itemName) {
  return Container(
      height: 150,
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
          Expanded(
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 70.0, vertical: 5.0),
                  child: Text(
                    itemName,
                    style: TextConstants.mainTextStyle(fontSize: 20),
                  ),
                )

            ),
          ),
        ],
      )
  );
}

class ViewInventoryScreenTabController extends GetxController {
  var selectedIndex = 0.obs;
}

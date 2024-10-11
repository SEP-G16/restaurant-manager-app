import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/components/date_input_field.dart';
import 'package:restaurant_manager/components/table_tile.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import '../../constants/text_constants.dart';
import 'package:restaurant_manager/controller/views/view_inventory_screen/view_inventory_screen_tab_controller.dart';

class ViewInventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewInventoryScreenTabController>(
      init: ViewInventoryScreenTabController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColourConstants.white,
          body: SafeArea(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.arrow_back,
                              color: ColourConstants.chineseBlack,
                              size: 30,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Inventory Management',
                            style: TextConstants.mainTextStyle(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Obx(
                          () => TabBar(
                        indicatorColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        controller: controller.tabController,
                        overlayColor: WidgetStateColor.resolveWith(
                                (_) => Colors.transparent),
                        tabs: <Widget>[
                          Tab(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              height: 60,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: controller.selectedIndex == 0
                                    ? ColourConstants.green
                                    : Colors.white,
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
                                color: controller.selectedIndex == 1
                                    ? ColourConstants.red
                                    : Colors.white,
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
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 20.0,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: [
                                    // First Tile
                                    _buildViewInventoryTile('Chicken Bun'),
                                    SizedBox(height: 10.0),
                                    // Second Tile
                                    _buildViewInventoryTile('Chicken Dumpling'),
                                  ],
                                ),

                              )
                            ],

                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 20.0,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: [
                                    // First Tile
                                    _buildViewInventoryTile('Soup'),
                                    SizedBox(height: 10.0),
                                    // Second Tile
                                    _buildViewInventoryTile('Cake'),
                                  ],
                                ),

                              )
                            ],

                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
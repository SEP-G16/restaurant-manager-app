import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/components/named_input_field.dart';
import 'package:restaurant_manager/components/table_tile.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/constants/text_constants.dart';
import 'package:restaurant_manager/controller/views/table_screen/table_screen_state_controller.dart';
import 'package:restaurant_manager/components/custom_drawer.dart';

class TableManagementScreen extends StatelessWidget {
  const TableManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TableScreenStateController());

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ActionButton(
        btnText: 'Add Table',
        onTap: () {
          int? tableNo;
          int? chairCount;

          Get.dialog(
            Dialog(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: ColourConstants.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 350,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Add Table',
                              style: TextConstants.mainTextStyle(),
                            ),
                            Spacer(),
                            Visibility(
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              visible: false,
                              child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      NamedInputField(
                          titleText: 'Table No',
                          onChanged: (value) {
                            tableNo = int.tryParse(value!);
                          }),
                      NamedInputField(
                          titleText: 'Chair Count',
                          onChanged: (value) {
                            chairCount = int.tryParse(value!);
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      ActionButton(
                          btnText: 'Add Table',
                          onTap: () async {
                            if (tableNo == null) {
                              Get.snackbar('Error', 'Please enter table number',
                                  snackPosition: SnackPosition.BOTTOM);
                              return;
                            }
                            if (chairCount == null) {
                              Get.snackbar('Error', 'Please enter chair count',
                                  snackPosition: SnackPosition.BOTTOM);
                              return;
                            }
                            await TableScreenStateController.instance.addTable(
                                tableNo: tableNo!, chairCount: chairCount!);
                            // Add table to database
                            Get.back();
                          })
                    ],
                  ),
                ),
              ),
            ),
            barrierDismissible: false,
          );
        },
      ),
      backgroundColor: ColourConstants.white,
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                        'Manage Tables',
                        style: TextConstants.mainTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await TableScreenStateController.instance.getTables();
                  },
                  child: Obx(
                    () => CustomScrollView(
                      slivers: TableScreenStateController
                              .instance.tableList.isNotEmpty
                          ? TableScreenStateController.instance.tableList
                              .map((table) {
                              return SliverList(
                                delegate: SliverChildListDelegate(
                                  [
                                    TableTile(
                                      table: table,
                                      onEditPressed: () {},
                                      onDeletePressed: () {},
                                      onQRPressed: () {
                                        Get.dialog(
                                          Dialog(
                                            child: Container(
                                              padding: EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: ColourConstants.white,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: 350,
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_back_ios_new_rounded,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          'QR Code',
                                                          style: TextConstants
                                                              .mainTextStyle(),
                                                        ),
                                                        Spacer(),
                                                        Visibility(
                                                          maintainSize: true,
                                                          maintainAnimation:
                                                              true,
                                                          maintainState: true,
                                                          visible: false,
                                                          child: IconButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .arrow_back_ios_new_rounded,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    'Scan this QR code to configure\nyour Virtual Waiter on Table ${table.tableNo}',
                                                    style: TextConstants
                                                        .subTextStyle(),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  QrImageView(
                                                    data: table.id.toString(),
                                                    version: QrVersions.auto,
                                                    size: 200.0,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  ActionButton(
                                                    btnText: 'Done',
                                                    onTap: () => Get.back(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              );
                            }).toList()
                          : <Widget>[
                              SliverFillRemaining(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Looks like no tables have been added yet!',
                                        textAlign: TextAlign.center,
                                        style: TextConstants.mainTextStyle(
                                            color:
                                                ColourConstants.chineseBlack),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

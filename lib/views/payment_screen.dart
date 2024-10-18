import 'package:flutter/material.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/components/complete_order_item_tile.dart';
import 'package:restaurant_manager/components/order_item_tile.dart';
import 'package:restaurant_manager/constants/text_constants.dart';
import 'package:restaurant_manager/components/custom_drawer.dart';

import '../constants/colour_constants.dart';

import 'package:get/get.dart';

import '../controller/views/payment_screen_state_controller.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentScreenStateController());

    return Scaffold(
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
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
                        'Manage Payments',
                        style: TextConstants.mainTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await PaymentScreenStateController.instance.getSessions();
                  },
                  child: Obx(
                    () => CustomScrollView(
                      slivers: PaymentScreenStateController
                              .instance.sessions.isNotEmpty
                          ? PaymentScreenStateController.instance.sessions
                              .map((session) {
                              return SliverList(
                                delegate: SliverChildListDelegate(
                                  [
                                    Container(
                                      padding: EdgeInsets.all(10.0),
                                      margin: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Table ${session.tableNo}',
                                                style: TextConstants
                                                    .mainTextStyle(),
                                              ),
                                              ActionButton(
                                                btnText: 'Mark as Paid',
                                                onTap: () async {
                                                  await PaymentScreenStateController.instance.updateSessionAsComplete(sessionId : session.sessionId);
                                                },
                                                height: 40,
                                                width: 160,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            children:
                                                session.orderList.map((order) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 1,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Order #${order.id}',
                                                          style: TextConstants
                                                              .mainTextStyle(
                                                                  fontSize: 24),
                                                        ),
                                                        Divider(),
                                                        Column(
                                                          children:
                                                              order.orderItems
                                                                  .map(
                                                                    (orderItem) =>
                                                                        CompleteOrderItemTile(orderItem: orderItem),
                                                                  )
                                                                  .toList(),
                                                        ),
                                                        // Divider(),
                                                        // Padding(
                                                        //   padding: const EdgeInsets.symmetric(horizontal: 20),
                                                        //   child: Row(
                                                        //     mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                                        //     children: [
                                                        //       Row(
                                                        //         children: [
                                                        //           Icon(Icons.money),
                                                        //           SizedBox(width: 15,),
                                                        //           Text('Order Total', style: TextConstants.mainTextStyle(fontSize: 22),),
                                                        //         ],
                                                        //       ),
                                                        //       Text(
                                                        //         '\$. ${order.totalAmount.toStringAsFixed(2)}',
                                                        //         style: TextConstants
                                                        //             .mainTextStyle(fontSize: 22),
                                                        //       ),
                                                        //     ],
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Total', style: TextConstants.mainTextStyle(),),
                                              Text('\$${session.totalAmount.toStringAsFixed(2)}', style: TextConstants.mainTextStyle(),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
                                        'Looks like no orders are complete yet!',
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

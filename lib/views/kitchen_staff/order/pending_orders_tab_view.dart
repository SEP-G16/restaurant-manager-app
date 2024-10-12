import 'package:flutter/material.dart';
import 'package:restaurant_manager/components/order_tile.dart';
import 'package:restaurant_manager/constants/text_constants.dart';
import 'package:restaurant_manager/controller/views/orders_screen/order_screen_main_state_controller.dart';
import 'package:restaurant_manager/enum/order_status.dart';
import 'package:get/get.dart';

import '../../../enum/order_item_status.dart';
import '../../../model/order.dart';

class PendingOrdersTabView extends StatelessWidget {
  const PendingOrdersTabView({super.key});

  @override
  Widget build(BuildContext context) {
    double displayHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 20.0,
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            Duration(seconds: 1),
          );
        },
        child: SingleChildScrollView(
          child: Obx(() {
            List<Order> children =
                OrderScreenMainStateController.instance.orderList.where(
              (order) {
                if (order.status == OrderStatus.Pending) {
                  return true;
                } else if (order.status == OrderStatus.Processing) {
                  if (order.orderItems.any((orderItem) =>
                      orderItem.status == OrderItemStatus.Pending)) {
                    return true;
                  } else {
                    return false;
                  }
                }
                return false;
              },
            ).toList();
            return Column(
              children: children.isNotEmpty
                  ? children.map((order) {
                      return OrderTile(
                        order: order,
                        orderItems: order.orderItems
                            .where((orderItem) =>
                                orderItem.status == OrderItemStatus.Pending)
                            .toList(),
                        onOrderItemAcceptCallBack: (int orderItemId) async {
                          await OrderScreenMainStateController.instance
                              .acceptPendingOrderItem(
                                  orderId: order.id, orderItemId: orderItemId);
                        },
                        onOrderItemRejectCallBack: (int orderItemId) async {
                          await OrderScreenMainStateController.instance
                              .rejectPendingOrderItem(
                                  orderId: order.id, orderItemId: orderItemId);
                        },
                        onOrderItemAcceptErrorCallBack: (Object? error) {
                          print(error);
                        },
                      );
                    }).toList()
                  : [
                      //find a better way to do this
                      Container(
                        height: displayHeight * 0.4,
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'No orders yet chef!',
                          style: TextConstants.mainTextStyle(),
                        ),
                      ),
                    ],
            );
          }),
        ),
      ),
    );
  }
}

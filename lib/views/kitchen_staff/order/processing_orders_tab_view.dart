import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/controller/views/orders_screen/order_screen_main_state_controller.dart';
import 'package:restaurant_manager/enum/order_item_status.dart';
import 'package:restaurant_manager/model/order_item.dart';

import '../../../components/order_tile.dart';
import '../../../enum/order_status.dart';

class ProcessingOrdersTabView extends StatelessWidget {
  const ProcessingOrdersTabView({super.key});

  @override
  Widget build(BuildContext context) {
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
            return Column(
              children: OrderScreenMainStateController.instance.orderList
                  .where(
                    (order) =>
                        order.status == OrderStatus.Processing &&
                        order.orderItems.any(
                          (orderItem) =>
                              orderItem.status == OrderItemStatus.Processing,
                        ),
                  )
                  .toList()
                  .map((order) {
                return OrderTile(
                  order: order,
                  orderItems: order.orderItems
                      .where((orderItem) =>
                          orderItem.status == OrderItemStatus.Processing)
                      .toList(),
                  onProcessingOrderItemCompletedCallBack:
                      (int orderItemId) async {
                    await OrderScreenMainStateController.instance
                        .completeProcessingOrderItem(
                            orderId: order.id, orderItemId: orderItemId);
                  },
                  onProcessingOrderItemCompleteErrorCallBack: (error) {
                    Get.snackbar(
                      "Error",
                      error.toString(),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                );
              }).toList(),
            );
          }),
        ),
      ),
    );
  }
}

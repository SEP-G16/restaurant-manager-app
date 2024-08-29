import 'package:flutter/material.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/components/order_item_tile.dart';
import 'package:restaurant_manager/components/order_tile.dart';
import 'package:restaurant_manager/constants/text_constants.dart';
import 'package:restaurant_manager/enum/order_status.dart';
import 'package:restaurant_manager/model/order.dart';
import 'package:restaurant_manager/model/order_item.dart';

import '../../../constants/colour_constants.dart';

class PendingOrdersTabView extends StatelessWidget {
  const PendingOrdersTabView({super.key});

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
          child: Column(
            children: [
              OrderTile(
                order: Order(
                    id: 12,
                    tableNo: 102,
                    orderItems: [
                      OrderItem(
                          id: 1,
                          menuItemName: 'Avocado Toast',
                          addOns: [],
                          additionalNotes: 'N/A',
                          quantity: 5),
                    ],
                    totalAmount: 12000,
                    status: OrderStatus.Pending),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

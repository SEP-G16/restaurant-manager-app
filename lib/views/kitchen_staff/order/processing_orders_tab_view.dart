import 'package:flutter/material.dart';

import '../../../components/order_tile.dart';
import '../../../enum/order_status.dart';
import '../../../model/order.dart';
import '../../../model/order_item.dart';

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
                    status: OrderStatus.Processing),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

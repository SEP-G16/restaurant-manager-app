import 'package:flutter/material.dart';
import 'package:restaurant_manager/components/processing_order_item_tile.dart';
import 'package:restaurant_manager/enum/order_status.dart';
import 'package:restaurant_manager/model/order.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';
import '../model/order_item.dart';
import 'order_item_tile.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: ColourConstants.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: double.maxFinite,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.list_alt_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Order #${order.id}',
                    style: TextConstants.mainTextStyle(fontSize: 30),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.table_restaurant_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Table ${order.tableNo}',
                    style: TextConstants.mainTextStyle(fontSize: 30),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: ColourConstants.chineseBlack.withOpacity(0.4),
          ),
          Text(
            'Meals',
            style: TextConstants.mainTextStyle(fontSize: 36),
          ),
          Column(
            children: order.orderItems
                .map<Widget>(
                  (orderItem) => order.status == OrderStatus.Pending
                      ? OrderItemTile(
                          orderItem: orderItem,
                          onAcceptPressed: () {},
                          onRejectPressed: () {},
                          onAcceptErrorCallBack: () {},
                          onRejectErrorCallBack: (error) {},
                        )
                      : ProcessingOrderItemTile(
                          orderItem: orderItem,
                          onCompletePressed: () {},
                        ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

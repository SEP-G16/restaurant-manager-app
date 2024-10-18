import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';
import '../model/order_item.dart';
import 'action_button.dart';

class CompleteOrderItemTile extends StatelessWidget {
  CompleteOrderItemTile({
    required this.orderItem,
  });

  final OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.fastfood_outlined,
                      size: 24,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      orderItem.menuItem.name,
                      style: TextConstants.subTextStyle(
                          fontWeight: FontWeight.w700, fontSize: 22),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                      text: 'Qty. - ',
                      style: TextConstants.subTextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'x${orderItem.quantity}',
                          style: TextConstants.subTextStyle(fontSize: 25),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Text(
              '\$${orderItem.totalAmount.toStringAsFixed(2)}',
              style: TextConstants.mainTextStyle(fontSize: 22),
            ),
          ],
        ),
      ],
    );
  }
}

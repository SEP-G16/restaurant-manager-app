import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';
import '../model/order_item.dart';
import 'action_button.dart';

class OrderItemTile extends StatelessWidget {
  OrderItemTile(
      {required this.orderItem,
      required this.onAcceptPressed,
      required this.onRejectPressed,
      this.onAcceptErrorCallBack,
      this.onRejectErrorCallBack});

  final OrderItem orderItem;
  final FutureOr<void> Function() onAcceptPressed;
  final FutureOr<void> Function() onRejectPressed;
  void Function(Object? e)? onAcceptErrorCallBack;
  void Function(Object? e)? onRejectErrorCallBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: ColourConstants.gamboge, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.fastfood_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      orderItem.menuItem.name,
                      style: TextConstants.subTextStyle(
                          fontWeight: FontWeight.w700, fontSize: 28),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Quantity - ',
                            style: TextConstants.subTextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${orderItem.quantity}x',
                                style: TextConstants.subTextStyle(fontSize: 25),
                              ),
                            ]),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'AddOns - ',
                          style: TextConstants.subTextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: orderItem.generateAddOnNote(),
                              style: TextConstants.subTextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Additional Notes - ',
                          style: TextConstants.subTextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: orderItem.additionalNotes == '' ? 'None' : orderItem.additionalNotes,
                              style: TextConstants.subTextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ],
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
              ActionButton(
                btnText: 'Accept',
                onTap: () async {
                  try {
                    await onAcceptPressed();
                  } catch (e) {
                    if (onAcceptErrorCallBack != null) {
                      onAcceptErrorCallBack!(e);
                    }
                  }
                },
                outlineMode: true,
                borderWidth: 2,
                borderColour: ColourConstants.green1,
              ),
              SizedBox(
                height: 15,
              ),
              ActionButton(
                btnText: 'Reject',
                onTap: () async {
                  try {
                    await onRejectPressed();
                  } catch (e) {
                    if (onRejectErrorCallBack != null) {
                      onRejectErrorCallBack!(e);
                    }
                  }
                },
                outlineMode: true,
                borderWidth: 2,
                borderColour: ColourConstants.red1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

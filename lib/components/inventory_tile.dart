import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_manager/model/inventory_item.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';
import 'action_button.dart';

class InventoryTile extends StatelessWidget {
  InventoryTile({
    required this.item,
    this.onMarkAsInStockPressed,
    this.onMarkAsOutOfStockPressed,
    this.onErrorCallBack,
  });

  InventoryItem item;
  FutureOr<void> Function()? onMarkAsInStockPressed;
  FutureOr<void> Function()? onMarkAsOutOfStockPressed;
  void Function(Object? e)? onErrorCallBack;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.fastfood_rounded),
              SizedBox(
                width: 10,
              ),
              Text(
                item.name,
                style: TextConstants.mainTextStyle(fontSize: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ActionButton(
                btnText: 'Mark as Out of Stock',
                onTap: () async {
                  try {
                    if (onMarkAsOutOfStockPressed != null) {
                      await onMarkAsOutOfStockPressed!();
                    }
                  } catch (e) {
                    if (onErrorCallBack != null) {
                      onErrorCallBack!(e);
                    }
                    ;
                  }
                },
                outlineMode: true,
                borderWidth: 2.0,
                borderColour: ColourConstants.red,
                outlineModeHoverColour: ColourConstants.red.withOpacity(0.1),
                width: 180,
                fontSize: 16,
                height: 40,
                isDisabled: item.isInStock ? false : true,
              ),
              SizedBox(width: 10.0),
              ActionButton(
                btnText: 'Mark as In Stock',
                onTap: () async {
                  try {
                    if (onMarkAsInStockPressed != null) {
                      await onMarkAsInStockPressed!();
                    }
                  } catch (e) {
                    if (onErrorCallBack != null) {
                      onErrorCallBack!(e);
                    }
                    ;
                  }
                },
                outlineMode: true,
                borderWidth: 2.0,
                borderColour: ColourConstants.green,
                outlineModeHoverColour: ColourConstants.green.withOpacity(0.1),
                width: 180,
                fontSize: 16,
                height: 40,
                isDisabled: item.isInStock ? true : false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

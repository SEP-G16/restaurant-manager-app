import 'package:flutter/material.dart';
import 'package:restaurant_manager/model/restaurant_table.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';

class TableTile extends StatelessWidget {
  const TableTile({
    required this.table,
    required this.checkValue,
    required this.onCheckBoxPressed,
  });

  final RestaurantTable table;
  final bool checkValue;
  final void Function(bool? value) onCheckBoxPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
      // width: 150,
      // height: 60,
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
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Table - ${table.tableNo}',
                style: TextConstants.mainTextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Icon(Icons.chair_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '# of Chairs - ${table.chairCount}',
                    style: TextConstants.subTextStyle(fontSize: 16),
                  ),
                ],
              ), //table id goes here
            ],
          ),
          Spacer(),
          Checkbox(value: checkValue, onChanged: onCheckBoxPressed),
        ],
      ),
    );
  }
}

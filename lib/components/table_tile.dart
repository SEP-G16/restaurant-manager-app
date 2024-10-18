import 'package:flutter/material.dart';
import 'package:restaurant_manager/model/restaurant_table.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';

class TableTile extends StatelessWidget {
  TableTile({
    required this.table,
    this.checkValue,
    this.onCheckBoxPressed,
    this.selectMode = false,
    this.onDeletePressed,
    this.onEditPressed,
    this.onQRPressed
  }) {
    if (selectMode) {
      assert(checkValue != null && onCheckBoxPressed != null, 'All values must be provided if in select mode');
    }
    else
      {
        assert(onDeletePressed != null && onEditPressed != null && onQRPressed != null, 'All functions must be provided if not in select mode');
      }
  }

  bool selectMode;
  final RestaurantTable table;
  bool? checkValue;
  void Function(bool? value)? onCheckBoxPressed;
  void Function()? onEditPressed;
  void Function()? onDeletePressed;
  void Function()? onQRPressed;

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
          Visibility(
            visible: selectMode,
            child: Checkbox(
              value: selectMode ? checkValue : false,
              onChanged: onCheckBoxPressed,
            ),
          ),
          Visibility(
            visible: !selectMode,
            child: Row(
              children: [
                GestureDetector(
                  onTap: onEditPressed,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onDeletePressed,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onQRPressed,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColourConstants.chineseBlack, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      Icons.qr_code,
                      color: ColourConstants.chineseBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

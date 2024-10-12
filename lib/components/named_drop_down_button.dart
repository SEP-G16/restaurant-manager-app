import 'package:flutter/material.dart';

import '../constants/text_constants.dart';
import 'custom_drop_down_button.dart';

class NamedDropDownButton extends StatelessWidget {
  NamedDropDownButton({
    required this.titleText,
    required this.value,
    required this.selectOptionValue,
    required this.onChanged,
    this.itemList,
    this.width,
    this.selectOptionText,
  });

  final String titleText;
  dynamic value;
  dynamic selectOptionValue;
  void Function(dynamic value)? onChanged;
  List<DropdownMenuItem<Object>>? itemList;
  double? width;
  String? selectOptionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: TextConstants.mainTextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 5.0,
          ),
          CustomDropDownButton(
            value: value,
            selectOptionValue: selectOptionValue,
            onChanged: onChanged,
            itemList: itemList,
            width: width,
            selectOptionText: selectOptionText,
          ),
        ],
      ),
    );
  }
}

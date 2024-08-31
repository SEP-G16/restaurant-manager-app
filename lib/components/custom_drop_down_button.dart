import 'package:flutter/material.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';

class CustomDropDownButton extends StatelessWidget {
  CustomDropDownButton({required this.value, this.itemList, required this.selectOptionValue, required this.onChanged, this.width,});

  dynamic value;
  dynamic selectOptionValue;
  List<DropdownMenuItem<Object>>? itemList;
  void Function(dynamic value)? onChanged;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: ColourConstants.ghostWhite,
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
      child: DropdownButton(
        style: TextConstants.subTextStyle(),
        underline: Container(),
        value: value,
        items: [
          DropdownMenuItem(
            value: selectOptionValue,
            child: Container(
              child: Text(
                'Select',
                style: TextConstants.subTextStyle(),
              ),
            ),
          ),
        ] +
            (itemList ?? []),
        onChanged: onChanged,
        isExpanded : true,
      ),
    );
  }
}

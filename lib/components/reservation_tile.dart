import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';
import '../model/reservation.dart';
import 'action_button.dart';

class ReservationTile extends StatelessWidget {
  const ReservationTile({
    required this.reservation,
    required this.onCancelCallBack,
  });

  final Reservation reservation;
  final void Function() onCancelCallBack;

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
      child: IntrinsicHeight(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reservation.customerName,
                  style: TextConstants.mainTextStyle(
                    fontSize: 20,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 25,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Date - ${DateFormat('yyyy/MM/dd').format(
                        reservation.reservedDate,
                      )}',
                      style: TextConstants.subTextStyle(),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people,
                      size: 25,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '# of People - ${reservation.peopleCount}',
                      style: TextConstants.subTextStyle(),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      size: 25,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Phone No. - ${reservation.phoneNo}',
                      style: TextConstants.subTextStyle(),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 25,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Time Slot - ${'${reservation.timeSlotStart.toString().padLeft(2, '0')}:00'}-${'${reservation.timeSlotEnd.toString().padLeft(2, '0')}:00'}',
                      style: TextConstants.subTextStyle(),
                    ),
                  ],
                ),
              ],
            ),
            VerticalDivider(
              color: ColourConstants.chineseBlack.withOpacity(0.8),
              width: 50,
              thickness: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tables',
                  style: TextConstants.mainTextStyle(fontSize: 20),
                ),
                Column(
                  children: reservation.tableList
                      .map(
                        (table) => Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 2,
                          ),
                          // padding: EdgeInsets.all(2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.table_restaurant_outlined),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Table ${table.tableNo
                                //table no
                                }',
                                style: TextConstants.subTextStyle(),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            Spacer(),
            ActionButton(
              btnText: 'Cancel Reservation',
              onTap: onCancelCallBack,
              fontSize: 18,
              outlineMode: true,
              borderColour: Colors.redAccent,
              borderWidth: 3.0,
              btnColor: Colors.transparent,
              textColor: Colors.redAccent,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}

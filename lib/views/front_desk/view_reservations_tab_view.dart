import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/date_input_field.dart';
import '../../components/loading_dialog.dart';
import '../../components/reservation_tile.dart';
import '../../constants/colour_constants.dart';
import '../../constants/text_constants.dart';
import '../../controller/views/reservation_screen/view_reservations_tab_view/view_reservations_date_controller.dart';
import '../../controller/views/reservation_screen/view_reservations_tab_view/view_reservations_search_text_controller.dart';
import '../../controller/views/reservation_screen/view_reservations_tab_view/view_reservations_tab_view_controller.dart';

class ViewReservationsTabView extends StatelessWidget {
  const ViewReservationsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return GetBuilder<ViewReservationsTabViewController>(
      init: ViewReservationsTabViewController(),
      builder: (mainCont) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: deviceSize.width * 0.4),
                    child: SearchAnchor(
                      builder:
                          (BuildContext context, SearchController controller) {
                        return GetBuilder<ViewReservationsSearchTextController>(
                            init: ViewReservationsSearchTextController(),
                            builder: (searchCont) {
                              return SearchBar(
                                onChanged: (value) {
                                  ViewReservationsTabViewController.instance
                                      .handleSearch(searchText: value);
                                },
                                controller: ViewReservationsTabViewController
                                    .instance.searchController,
                                hintText: 'Search by Name or Phone Number',
                                hintStyle: WidgetStateTextStyle.resolveWith(
                                  (_) => TextConstants.subTextStyle(
                                    fontSize: 16,
                                    color: ColourConstants.chineseBlack
                                        .withOpacity(0.7),
                                  ),
                                ),
                                leading: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.search,
                                  ),
                                ),
                              );
                            });
                      },
                      suggestionsBuilder:
                          (BuildContext context, SearchController controller) {
                        return [];
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Filter by Date',
                        style: TextConstants.subTextStyle(),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      GetBuilder<ViewReservationsDateController>(
                        init: ViewReservationsDateController(),
                        builder: (dateCont) {
                          return Obx(
                            () => DateInputField(
                              height: 50,
                              width: 200,
                              selectedDate: dateCont.selectedDate,
                              onPressed: () async {
                                DateTime now = DateTime.now();
                                DateTime twoWeekDate =
                                    now.add(Duration(days: 14));

                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  firstDate: now,
                                  lastDate: twoWeekDate,
                                );
                                dateCont.selectedDate = selectedDate ?? now;

                                //TODO:Throw error if null
                                LoadingDialog(
                                  callerFunction: () async {
                                    await mainCont.handleDateChange(
                                        selectedDate: selectedDate!);
                                  },
                                );
                              },
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Obx(
                  () => mainCont.displayedReservations.isEmpty
                      ? Center(
                          child: Text(
                            'Nothing to see here!',
                            style: TextConstants.mainTextStyle(),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Obx(
                            () => Column(
                              children: mainCont.displayedReservations
                                  .map(
                                    (reservation) => ReservationTile(
                                      reservation: reservation,
                                      onCancelCallBack: () {},
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

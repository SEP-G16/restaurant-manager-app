import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/views/front_desk/reservation_screen.dart';
import 'package:restaurant_manager/views/loading_screen.dart';
import 'package:restaurant_manager/views/login_screen.dart';

void main() {
  runApp(const RestaurantManager());
}

class RestaurantManager extends StatelessWidget {
  const RestaurantManager({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Virtual Waiter',
      theme: ThemeData(
        useMaterial3: true,
        textSelectionTheme: const TextSelectionThemeData(
           cursorColor: ColourConstants.gamboge,
          selectionColor: ColourConstants.gamboge,
          selectionHandleColor: ColourConstants.gamboge
        ),
        canvasColor: ColourConstants.white,
        colorScheme: ColorScheme.light(primary: ColourConstants.gamboge),
      ),
      home: ReservationScreen(),
    );
  }
}


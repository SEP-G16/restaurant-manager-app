import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_manager/constants/svg_constants.dart';
import 'package:restaurant_manager/constants/text_constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.string(SvgConstants.loginCoverImage, height: 300,),
              Text('Welcome to\nRestaurant Management Application!', textAlign: TextAlign.center, style: TextConstants.mainTextStyle(),),
            ],
          ),
        ),
      ),
    );
  }
}

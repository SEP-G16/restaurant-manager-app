import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/components/input_field.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/constants/svg_constants.dart';
import 'package:restaurant_manager/constants/text_constants.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/views/loading_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourConstants.white,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: OrientationBuilder(
              builder: (context, orientation) {
                print(orientation);
                if (orientation == Orientation.portrait) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.string(SvgConstants.loginCoverImage),
                        SizedBox(
                          height: 50.0,
                        ),
                        Text(
                          'Login to Your Account',
                          style: TextConstants.mainTextStyle(fontSize: 40),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        InputField(
                          labelText: 'Email',
                          onChanged: (email) {},
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InputField(
                          labelText: 'Password',
                          onChanged: (password) {},
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ActionButton(btnText: 'Login', onTap: () {
                          Get.to(() => LoadingScreen());
                        }),
                      ],
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.string(SvgConstants.loginCoverImage),
                        Column(
                          children: [
                            Text(
                              'Login to Your Account',
                              style: TextConstants.mainTextStyle(fontSize: 40),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            InputField(
                              labelText: 'Email',
                              onChanged: (email) {},
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            InputField(
                              labelText: 'Password',
                              onChanged: (password) {},
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            ActionButton(btnText: 'Login', onTap: () {
                              Get.to(() => LoadingScreen());
                            }),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

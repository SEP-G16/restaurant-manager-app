import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/components/input_field.dart';
import 'package:restaurant_manager/constants/colour_constants.dart';
import 'package:restaurant_manager/constants/svg_constants.dart';
import 'package:restaurant_manager/constants/text_constants.dart';
import 'package:get/get.dart';
import 'package:restaurant_manager/controller/data/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;

    Widget _buildLoginForm() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login to Your Account',
            style: TextConstants.mainTextStyle(fontSize: 40),
          ),
          SizedBox(height: 50.0),
          InputField(
            labelText: 'Email',
            onChanged: (value) {
              email = value;
            },
          ),
          SizedBox(height: 20.0),
          InputField(
            labelText: 'Password',
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
          ),
          SizedBox(height: 20.0),
          ActionButton(
            btnText: 'Login',
            onTap: () async {
              if (email == null) {
                Get.snackbar('Error', 'Please enter your email',
                    snackPosition: SnackPosition.BOTTOM);
                return;
              }
              if (password == null) {
                Get.snackbar('Error', 'Please enter your password',
                    snackPosition: SnackPosition.BOTTOM);
                return;
              }

              RegExp emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
              if(!emailRegExp.hasMatch(email!))
                {
                  Get.snackbar('Error', 'Please enter a valid email',
                      snackPosition: SnackPosition.BOTTOM);
                  return;
                }
              try {
                await AuthController.instance
                    .login(email: email!, password: password!);
              } catch (e) {
                print(e);
                Get.snackbar('Error', e.toString(),
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: ColourConstants.white,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: OrientationBuilder(
              builder: (context, orientation) {
                final isPortrait = orientation == Orientation.portrait;
                return SingleChildScrollView(
                  child: isPortrait
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.string(SvgConstants.loginCoverImage),
                            SizedBox(height: 50.0),
                            _buildLoginForm(),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.string(SvgConstants.loginCoverImage),
                            SizedBox(width: 50.0),
                            _buildLoginForm(),
                          ],
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

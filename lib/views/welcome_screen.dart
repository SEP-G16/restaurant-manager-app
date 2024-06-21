import 'package:flutter/material.dart';
import 'package:restaurant_manager/components/message_dialog_box.dart';
import 'package:restaurant_manager/controller/views/welcome_screen_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: const Text(
            'Hello there!\nTime to manage your restaurant',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

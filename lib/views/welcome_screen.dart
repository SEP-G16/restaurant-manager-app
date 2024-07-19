import 'package:flutter/material.dart';
import 'package:restaurant_manager/components/message_dialog_box.dart';
import 'package:restaurant_manager/controller/network/web-socket-controller.dart';
import 'package:restaurant_manager/controller/views/welcome_screen_controller.dart';

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
              TextButton(
                onPressed: () {
                  WebSocketController.instance.sendWSRequest(
                    message: 'onOrderAccepted',
                    data: {
                      'tableId': '12',
                      'tableNo' : 12,
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.black,
                  child: Text(
                    'Accept Order',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  WebSocketController.instance.sendWSRequest(
                    message: 'onOrderPrepared',
                    data: {
                      'tableId': '12',
                      'tableNo' : 12,
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.black,
                  child: Text(
                    'Order Prepared',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  WebSocketController.instance.sendWSRequest(
                    message: 'onOrderDelivered',
                    data: {
                      'tableId': '12',
                      'tableNo' : 12,
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.black,
                  child: Text(
                    'Order Delivered',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

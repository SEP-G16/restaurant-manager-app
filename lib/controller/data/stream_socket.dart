import 'dart:async';

import 'package:get/get.dart';

class StreamSocket extends GetxController {
  static StreamSocket instance = Get.find();

  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void _dispose() {
    _socketResponse.close();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _dispose();
    super.onClose();
  }
}

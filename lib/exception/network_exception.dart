import 'package:restaurant_manager/exception/base_exception.dart';

class NetworkException extends BaseException{
  NetworkException(String? message) : super(message: message);

  @override
  String toString() => message ?? super.toString();
}
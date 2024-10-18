import 'package:restaurant_manager/exception/base_exception.dart';

class RequestUnauthorizedException extends BaseException{
  RequestUnauthorizedException(String? message) : super(message: message);

  @override
  String toString() => message ?? super.toString();
}
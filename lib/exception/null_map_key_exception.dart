import 'package:restaurant_manager/exception/base_exception.dart';

class NullMapKeyException extends BaseException{
  NullMapKeyException({String? message}) : super(message: message);

  @override
  String toString() => message ?? super.toString();
}
import 'package:restaurant_manager/exception/base_exception.dart';

class TypeMismatchException extends BaseException{
  TypeMismatchException({String? message}) : super(message: message);

  @override
  String toString() => message ?? super.toString();


}
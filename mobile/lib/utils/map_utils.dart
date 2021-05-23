import 'package:dio/dio.dart';

extension Converter on String {
  String convertToShortXex() {
    var name;
    switch (this) {
      case "Мужской":
        name = "M";
        break;
      case "Женский":
        name = "F";
        break;
      default:
        name = "U";
        break;
    }
    return name;
  }
}

extension ConvertersXex on int {
  String convertToLongXex() {
    var name;
    switch (this) {
      case 1:
        name = "Мужской";
        break;
      case 2:
        name = "Женский";
        break;
      default:
        name = "Другой";
        break;
    }
    return name;
  }
}

extension Converters on bool {
  int convertToUserType() {
    var id = 0;
    switch (this) {
      case false:
        id = 1;
        break;
      case true:
        id = 2;
        break;
      default:
        break;
    }
    return id;
  }
}

extension ConvertersCategory on String {
  int convertCategoryNameToId() {
    var id = 0;
    switch (this) {
      case 'Backend':
        id = 1;
        break;
      case 'Frontend':
        id = 2;
        break;
      case 'Designer':
        id = 3;
        break;
      case 'PM':
        id = 4;
        break;
      case 'DS':
        id = 5;
        break;
      case 'IOS':
        id = 6;
        break;
      case 'Android':
        id = 7;
        break;
    }
  }
}

extension ConvertersCategoryName on int {
  String convertCategoryNameToId() {
    switch (this) {
      case 1:
        return 'Backend';
      case 2:
        return 'Frontend';
      case 3:
        return 'Designer';
      case 4:
        return 'PM';
      case 5:
        return 'DS';
      case 6:
        return 'IOS';
      case 7:
        return 'Android';
    }
  }
}

class HttpException implements Exception {
  Response response;

  HttpException(this.response);
}

bool isNumericUsing_tryParse(String string) {
  if (string == null || string.isEmpty) {
    return false;
  }
  final number = num.tryParse(string);
  if (number == null) {
    return false;
  }
  return true;
}

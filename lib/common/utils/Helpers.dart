import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

mixin class Helpers {
  Uint8List base64ToImage(String image) {
    return base64Decode(replaceTypeBase64(image));
  }

  String replaceTypeBase64(String value) {
    try {
      var strImage = RegExp(r'^data:image\/[a-z]+;base64,');
      var data = value.replaceAll(strImage, '');
      return data;
    } catch (e) {
      return "";
    }
  }

  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }
    return string[0].toUpperCase() + string.substring(1);
  }

  String price(dynamic price) {
    NumberFormat currencyFormatter;

    currencyFormatter = NumberFormat.currency(
      locale: 'id',
      decimalDigits: 0,
      symbol: 'IDR ',
    );

    if (price.runtimeType == String) {
      return currencyFormatter.format(int.parse(price!));
    }
    return currencyFormatter.format(price);
  }

  final RegExp regXUppercase = RegExp(r'[A-Z]');
  final RegExp regXLowercase = RegExp(r'[a-z]');
  final RegExp regXNumber = RegExp('[0-9]');
  final RegExp regXSymbols =
      RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+=' "'" ']');

  bool isValidEmail(String? inputString, {bool isRequired = false}) {
    bool isInputStringValid = false;

    if ((inputString == null ? true : inputString.isEmpty) && !isRequired) {
      isInputStringValid = true;
    }

    if (inputString != null) {
      const pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      final regExp = RegExp(pattern);

      isInputStringValid = regExp.hasMatch(inputString);
    }

    return isInputStringValid;
  }

  bool isValidPassword(String inputString) {
    // bool lowerCase = false;
    // bool upperCase = false;
    // bool hasNumber = false;
    bool character = false;

    bool isInputStringValid = false;

    // lowerCase = inputString.contains(regXLowercase) ? true : false;

    // upperCase = inputString.contains(regXUppercase) ? true : false;

    // hasNumber = inputString.contains(regXNumber) ? true : false;

    character = inputString.length >= 8 ? true : false;

    if (character) {
      isInputStringValid = true;
    } else {
      isInputStringValid = false;
    }

    return isInputStringValid;
  }

  bool isValidPhoneNumber(String? value) =>
      RegExp(r'^\+?08[0-9]{9,12}$').hasMatch(value ?? '');

  String? censorText(String? values) {
    var newString = [];
    values?.split('').asMap().forEach((index, value) {
      if (index >= 3 &&
          index <= values.length - 4 &&
          value.contains("@") == false) {
        newString.add(value.replaceAll(value, "*"));
      } else {
        newString.add(value);
      }
    });
    return newString.join();
  }

  String? getInitialString(String values) {
    List<String> names = values.split(" ");
    String initials = "";
    int numWords = 1;

    if (names.length < 2) {
      numWords = names.length;
    } else {
      numWords = 2;
    }

    for (var i = 0; i < numWords; i++) {
      initials += names[i][0].toUpperCase();
    }

    return initials;
  }

  String? getInitialName(String values) {
    List<String> names = values.split(" ");
    return names.first;
  }

  // null safety
  double safeDouble(double? value) {
    return value ?? -1;
  }

  int safeInt(int? value) {
    return value ?? -1;
  }

  String safeString(String? value) {
    return value ?? "N/A";
  }

  bool safeBool(bool? value) {
    return value ?? false;
  }

  // change array 0 with new data and remove last index
  List<dynamic> updateArray(List<dynamic> array, String addToStartOfArray) {
    return array
      ..insert(0, addToStartOfArray)
      ..removeLast();
  }

  String formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return 'Now';
    } else if (date.day == now.subtract(const Duration(days: 1)).day &&
        date.month == now.subtract(const Duration(days: 1)).month &&
        date.year == now.subtract(const Duration(days: 1)).year) {
      return 'Yesterday';
    } else {
      // Format date for older dates
      return 'Last ${date.day}.${DateFormat('MMMM').format(date)}.${date.year}';
    }
  }

  String formatTime(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  CurrencyInputFormatter({this.maxDigits = 10});

  final int maxDigits;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newValueText = newValue.text;

    double value = double.parse(newValueText);
    NumberFormat formatter = NumberFormat("#,###", "en_US");
    String newText = formatter.format(value);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }

  int _replaceMoney(TextEditingController controller) {
    String cleaned = controller.text.replaceAll(',', '');
    int value = int.parse(cleaned);
    return value;
  }
}

import 'package:flutter/material.dart';

class GetDatePicker {
  static Future<DateTime?> pickDate(BuildContext context,
      {required DateTime? initialDate, required DateTime lastDate, required DateTime firstDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    return picked;
  }
}

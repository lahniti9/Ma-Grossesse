import 'package:flutter/material.dart';

Future<DateTime?> calculateDueDate(BuildContext context) async {
  final lastPeriod = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now().subtract(const Duration(days: 365)),
    lastDate: DateTime.now(),
  );
  return lastPeriod?.add(const Duration(days: 280)); // 40 weeks
}

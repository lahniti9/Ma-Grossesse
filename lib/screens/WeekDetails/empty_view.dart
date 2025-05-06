// views/empty_view.dart
import 'package:flutter/material.dart';
import 'package:pregnancy_tracker/utils/colors.dart';

Widget buildEmptyView() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.info_outline, size: 48, color: AppColors.colorScheme.primary),
        const SizedBox(height: 16),
        Text(
          'Aucune donnée disponible',
          style: TextStyle(fontSize: 18, color: AppColors.colorScheme.onSurface),
        ),
      ],
    ),
  );
}
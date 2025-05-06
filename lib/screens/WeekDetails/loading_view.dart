// views/loading_view.dart
import 'package:flutter/material.dart';
import 'package:pregnancy_tracker/utils/colors.dart';

Widget buildLoadingView() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(color: AppColors.colorScheme.primary),
        const SizedBox(height: 16),
        Text(
          'Chargement des conseils...',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.colorScheme.onSurface,
          ),
        ),
      ],
    ),
  );
}

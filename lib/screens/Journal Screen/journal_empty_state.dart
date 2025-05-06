import 'package:flutter/material.dart';
import 'package:pregnancy_tracker/utils/colors.dart';

class JournalEmptyState extends StatelessWidget {
  final VoidCallback onAddEntry;

  const JournalEmptyState({super.key, required this.onAddEntry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.book_rounded,
            size: 64,
            color: AppColors.primaryColor.withOpacity(0.3),
          ),
          const SizedBox(height: 20),
          Text(
            'Votre journal est vide',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.darkPink,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Commencez à documenter votre parcours de grossesse en ajoutant vos premières notes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onAddEntry,
            icon: const Icon(Icons.add_rounded, size: 20),
            label: const Text('Ajouter une note'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

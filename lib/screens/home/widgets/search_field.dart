// widgets/search_field.dart
import 'package:flutter/material.dart';
import 'package:pregnancy_tracker/utils/colors.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String searchQuery;

  const SearchField({
    super.key,
    required this.onChanged,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Rechercher une semaine...',
          prefixIcon: Icon(Icons.search, color: AppColors.primaryColor),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          suffixIcon:
              searchQuery.isNotEmpty
                  ? IconButton(
                    icon: Icon(Icons.clear, color: AppColors.primaryColor),
                    onPressed: () => onChanged(''),
                  )
                  : null,
        ),
      ),
    );
  }
}

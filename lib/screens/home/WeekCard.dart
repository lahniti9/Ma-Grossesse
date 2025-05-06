// ignore: file_names
import 'package:flutter/material.dart';
import 'package:pregnancy_tracker/screens/WeekDetails/week_details_screen.dart';

class WeekCard extends StatelessWidget {
  final int week;
  final bool isCurrent;
  final Color primaryColor;
  final Color secondaryColor;

  const WeekCard({
    super.key,
    required this.week,
    required this.isCurrent,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeekDetailsScreen(week: week),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient:
                isCurrent
                    ? LinearGradient(
                      colors: [primaryColor, secondaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                    : null,
            color: isCurrent ? null : Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Semaine',
                  style: TextStyle(
                    fontSize: 12,
                    color: isCurrent ? Colors.white : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  week.toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isCurrent ? Colors.white : primaryColor,
                  ),
                ),
                if (isCurrent)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Icon(Icons.circle, size: 8, color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

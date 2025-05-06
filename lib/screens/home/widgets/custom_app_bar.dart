// widgets/custom_app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int? currentWeek;
  final VoidCallback onDatePressed;
  final VoidCallback onSettingsPressed;

  const CustomAppBar({
    super.key,
    required this.currentWeek,
    required this.onDatePressed,
    required this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 248, 126, 166),
              const Color.fromARGB(255, 179, 39, 125),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.2),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(children: [_buildAnimatedWeekIndicator()]),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Tooltip(
            message: 'Définir date des dernières règles',
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onDatePressed,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.15),
                ),
                child: Icon(Icons.event_note, color: Colors.white, size: 24),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 13),
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.15),
              ),
              child: Icon(Icons.more_vert, color: Colors.white, size: 35),
            ),
            onPressed: onSettingsPressed,
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedWeekIndicator() {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.8, end: 1.0),
      duration: Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'S',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${currentWeek ?? '-'}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      curve: Curves.easeInOut,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

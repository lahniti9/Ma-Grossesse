import 'package:flutter/material.dart';
import 'tip_card.dart';

class BehaviorTipsTab extends StatelessWidget {
  const BehaviorTipsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        TipCard(
          title: 'Faire des exercices légers',
          subtitle: 'Comme marcher pendant 30 minutes par jour',
          icon: Icons.directions_walk,
        ),
        TipCard(
          title: 'Avoir suffisamment de repos',
          subtitle: 'Au moins 8 heures de sommeil par nuit',
          icon: Icons.mood,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'tip_card.dart';

class NutritionTipsTab extends StatelessWidget {
  const NutritionTipsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        TipCard(
          title: 'Consommer des aliments riches en fer',
          subtitle: 'Comme les épinards et la viande rouge',
          icon: Icons.restaurant,
        ),
        TipCard(
          title: 'Boire suffisamment d\'eau',
          subtitle: 'Au moins 8-10 verres par jour',
          icon: Icons.local_drink,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'tip_card.dart';

class AppointmentsTab extends StatelessWidget {
  const AppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        TipCard(
          title: 'Prochain rendez-vous chez le médecin',
          subtitle: '15 juin 2023 - 10:00 AM',
          icon: Icons.calendar_today,
        ),
        TipCard(
          title: 'Examen échographique',
          subtitle: '22 juin 2023 - 11:00 AM',
          icon: Icons.calendar_today,
        ),
      ],
    );
  }
}

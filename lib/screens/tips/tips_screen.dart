import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Changed from 3 to 2
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Conseils',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
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
                  color: Colors.purple.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            tabs: [
              Tab(text: 'Nutrition'),
              Tab(
                text: 'Attitude',
              ), // You can also use "Habitudes" or another word
            ],
          ),
        ),
        body: const TabBarView(
          children: [_NutritionTipsTab(), _BehaviorTipsTab()],
        ),
      ),
    );
  }
}

class _NutritionTipsTab extends StatelessWidget {
  const _NutritionTipsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _TipCard(
          title: 'Aliments riches en fer',
          subtitle:
              'Épinards, viande rouge et légumineuses pour prévenir l\'anémie',
          icon: Icons.restaurant,
          cardColor: const Color(0xFFFCE4EC), // Soft pink
        ),
        _TipCard(
          title: 'Hydratation',
          subtitle:
              '8-10 verres d\'eau par jour pour maintenir le liquide amniotique',
          icon: Icons.local_drink,
          cardColor: const Color(0xFFE3F2FD), // Light blue
        ),
        _TipCard(
          title: 'Acide folique',
          subtitle:
              '400 mcg quotidiennement pour le développement neural du bébé',
          icon: Icons.health_and_safety,
          cardColor: const Color(0xFFE8F5E9), // Mint green
        ),
        _TipCard(
          title: 'Repos',
          subtitle: 'Sieste de 20-30 minutes pour réduire la fatigue',
          icon: Icons.hotel,
          cardColor: const Color(0xFFFFF8E1), // Light yellow
        ),
        _TipCard(
          title: 'Exercice doux',
          subtitle: 'Yoga prénatal ou marche 30 minutes 3x/semaine',
          icon: Icons.directions_walk,
          cardColor: const Color(0xFFF3E5F5), // Lavender
        ),
        _TipCard(
          title: 'Éviter le stress',
          subtitle: 'Techniques de respiration profonde quotidiennes',
          icon: Icons.spa,
          cardColor: const Color(0xFFE0F7FA), // Light cyan
        ),
        _TipCard(
          title: 'Suivi médical',
          subtitle: 'Respectez tous vos rendez-vous prénataux',
          icon: Icons.medical_services,
          cardColor: const Color(0xFFF1F8E9), // Pale green
        ),
        _TipCard(
          title: 'Position de sommeil',
          subtitle: 'Dormir sur le côté gauche pour meilleure circulation',
          icon: Icons.airline_seat_individual_suite,
          cardColor: const Color(0xFFEDE7F6), // Light purple
        ),
        _TipCard(
          title: 'Éviter substances nocives',
          subtitle: 'Zéro alcool, tabac et caféine excessive',
          icon: Icons.smoke_free,
          cardColor: const Color(0xFFFFEBEE), // Light red
        ),
        _TipCard(
          title: 'Préparation à l\'accouchement',
          subtitle: 'Exercices du plancher pelvien quotidiennement',
          icon: Icons.self_improvement,
          cardColor: const Color(0xFFE0F2F1), // Teal
        ),
      ],
    );
  }
}

class _BehaviorTipsTab extends StatelessWidget {
  const _BehaviorTipsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _TipCard(
          title: 'Exercices légers',
          subtitle: 'Marcher 30 minutes par jour pour améliorer la circulation',
          icon: Icons.directions_walk,
          cardColor: const Color(0xFFE3F2FD), // Light blue
        ),
        _TipCard(
          title: 'Repos suffisant',
          subtitle: '8 heures de sommeil minimum pour une bonne récupération',
          icon: Icons.night_shelter,
          cardColor: const Color(0xFFE8F5E9), // Light green
        ),
        _TipCard(
          title: 'Hydratation',
          subtitle: 'Boire 2 litres d\'eau par jour pour rester hydratée',
          icon: Icons.local_drink,
          cardColor: const Color(0xFFE0F7FA), // Light cyan
        ),
        _TipCard(
          title: 'Alimentation équilibrée',
          subtitle:
              'Consommez des fruits, légumes et protéines quotidiennement',
          icon: Icons.restaurant,
          cardColor: const Color(0xFFF3E5F5), // Light purple
        ),
        _TipCard(
          title: 'Préparation à l\'accouchement',
          subtitle: 'Pratiquez des exercices de respiration quotidiennement',
          icon: Icons.self_improvement,
          cardColor: const Color(0xFFFFF8E1), // Light amber
        ),
        _TipCard(
          title: 'Évitement du stress',
          subtitle: 'Méditation ou yoga prénatal pour se détendre',
          icon: Icons.spa,
          cardColor: const Color(0xFFF1F8E9), // Light lime
        ),
        _TipCard(
          title: 'Visites médicales',
          subtitle: 'Ne manquez aucun rendez-vous prénatal avec votre médecin',
          icon: Icons.medical_services,
          cardColor: const Color(0xFFFCE4EC), // Light pink
        ),
        _TipCard(
          title: 'Suppléments vitaminés',
          subtitle: 'Prenez votre acide folique et fer comme prescrit',
          icon: Icons.medication,
          cardColor: const Color(0xFFE8EAF6), // Light indigo
        ),
        _TipCard(
          title: 'Posture correcte',
          subtitle: 'Maintenez une bonne posture pour éviter les maux de dos',
          icon: Icons.airline_seat_recline_normal,
          cardColor: const Color(0xFFE0F2F1), // Light teal
        ),
        _TipCard(
          title: 'Préparation mentale',
          subtitle: 'Lisez des livres sur la parentalité et la grossesse',
          icon: Icons.menu_book,
          cardColor: const Color(0xFFEFEBE9), // Light brown
        ),
      ],
    );
  }
}

class _TipCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color cardColor;

  const _TipCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.cardColor = const Color(0xFFF8F4FF), // Default soft lavender
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Container
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getIconColor(context).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(icon, size: 24, color: _getIconColor(context)),
                  ),
                ),
                const SizedBox(width: 16),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getIconColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.pink[300]!
        : Colors.pink;
  }
}

# 🍼 Suivi de Grossesse – Flutter App

Une application mobile développée avec **Flutter**, dédiée au **suivi personnalisé de grossesse**. Elle accompagne les futures mamans semaine après semaine, en leur fournissant des conseils utiles, un journal de grossesse, des rappels de rendez-vous, et bien plus encore.

---

## 📱 Fonctionnalités

### 🏠 Accueil
- Vue générale de la grossesse en cours
- Barre de recherche
- Affichage de la progression semaine par semaine

### 📅 Détails Hebdomadaires
- Conseils médicaux, nutritionnels et comportementaux
- Pages de suivi (advice_page, follow_up_page, etc.)

### 📔 Journal de Grossesse
- Ajouter des entrées personnelles
- Affichage sous forme de cartes
- Sauvegarde via `journal_repository`

### 💡 Conseils & Astuces
- Onglets pour la nutrition, le comportement, et les rendez-vous
- Composants réutilisables comme `tip_card.dart`

### ⚙️ Autres Écrans
- Écran d'aide
- Écran de paramètres
- Écrans de chargement, erreur et vues vides

---

## 🛠️ Structure du Projet

```bash
lib/
│
├── screens/
│   ├── home/
│   │   ├── home_screen.dart
│   │   ├── WeekCard.dart
│   │   └── widgets/ (custom widgets: app bar, progress header, etc.)
│   │
│   ├── journal_screen/
│   │   ├── journal_screen.dart
│   │   ├── journal_entry_card.dart
│   │   ├── journal_entry_dialog.dart
│   │   └── journal_repository.dart
│   │
│   ├── tips/
│   │   ├── tips_screen.dart
│   │   ├── behavior_tips_tab.dart
│   │   ├── nutrition_tips_tab.dart
│   │   └── appointments_tab.dart
│   │
│   └── week_details/
│       ├── week_details_screen.dart
│       ├── advice_page.dart
│       ├── follow_up_page.dart
│       ├── error_view.dart
│       ├── empty_view.dart
│       └── loading_view.dart
│
├── services/
│   ├── api_service.dart
│   └── api_cache.dart
│
├── utils/
│   └── (utilitaires généraux)
│
├── my_app.dart
└── main.dart
📌 À venir
Notifications de rappel

Synchronisation avec le cloud

Suivi de santé intégré

Statistiques sur l’évolution

📧 Contact
Développé par Ismail Lahniti
Email lhnitismail@gmail.com
Étudiant en développement mobile – Rabat, Maroc
Souhaites-tu que je te crée un fichier prêt à copier-coller dans ton projet ?

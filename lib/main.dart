import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pregnancy_tracker/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation du formatage de date pour le français
  await initializeDateFormatting('fr_FR');

  // Initialisation du plugin de notifications

  // Lancer l'application
  runApp(const MyApp());
}

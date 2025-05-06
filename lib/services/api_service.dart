import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'api_cache.dart';

class ApiService {
  static const String _baseUrl =
      "https://apibabysteps-production.up.railway.app";
  static const Map<String, String> _languageEndpoints = {
    'english': 'english',
    'french': 'frensh',
    'arabic': 'arabe',
  };

  static Future<Map<String, dynamic>> getWeekDetails(
    int week, {
    String language = 'arabic',
  }) async {
    // 1. Vérifier d'abord le cache
    final cachedData = await ApiCache.getWeekData(week, language);
    if (cachedData != null) {
      return cachedData;
    }

    // 2. Récupérer les données depuis l'API si elles ne sont pas en cache
    try {
      final endpoint = _languageEndpoints[language] ?? 'arabe';
      final response = await http
          .get(Uri.parse("$_baseUrl/api/pregnancy/$endpoint/week/$week"))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // 3. Enregistrer les données dans le cache
        await ApiCache.saveWeekData(week, language, data);

        return data;
      } else {
        throw _handleApiError(response.statusCode);
      }
    } catch (e) {
      // 4. Essayer d'utiliser les données expirées du cache si disponibles
      final staleData = await ApiCache.getWeekData(week, language);
      if (staleData != null) return staleData;

      throw _handleNetworkError(e);
    }
  }

  static String _handleApiError(int statusCode) {
    switch (statusCode) {
      case 404:
        return "Données non disponibles pour cette semaine";
      case 500:
        return "Erreur interne du serveur";
      default:
        return "Erreur API (code $statusCode)";
    }
  }

  static String _handleNetworkError(dynamic error) {
    if (error is TimeoutException) {
      return "Le délai de connexion au serveur a expiré";
    } else {
      return "Échec de la connexion au serveur : ${error.toString()}";
    }
  }
}

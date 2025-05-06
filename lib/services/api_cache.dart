import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiCache {
  static const String _cacheKey = 'pregnancy_weeks_cache';
  static const Duration _cacheDuration = Duration(days: 1);

  // Sauvegarder les données d'une semaine spécifique dans le cache
  static Future<void> saveWeekData(
    int week,
    String language,
    Map<String, dynamic> data,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final cache = await getCache();

    cache['$language-$week'] = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    await prefs.setString(_cacheKey, json.encode(cache));
  }

  // Récupérer les données d'une semaine depuis le cache si elles ne sont pas expirées
  static Future<Map<String, dynamic>?> getWeekData(
    int week,
    String language,
  ) async {
    final cache = await getCache();
    final cachedData = cache['$language-$week'];

    if (cachedData != null) {
      final timestamp = cachedData['timestamp'] as int;
      final age = DateTime.now().millisecondsSinceEpoch - timestamp;

      if (age < _cacheDuration.inMilliseconds) {
        return cachedData['data'] as Map<String, dynamic>;
      }
    }
    return null;
  }

  // Obtenir tout le cache enregistré
  static Future<Map<String, dynamic>> getCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheJson = prefs.getString(_cacheKey);
    return cacheJson != null
        ? Map<String, dynamic>.from(json.decode(cacheJson))
        : {};
  }

  // Vider le cache complètement
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }
}

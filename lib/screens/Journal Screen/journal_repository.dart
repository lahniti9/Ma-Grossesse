import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class JournalRepository {
  static const String _storageKey = 'journal_entries';

  Future<List<Map<String, String>>> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final entriesJson = prefs.getStringList(_storageKey) ?? [];
    return entriesJson
        .map((entry) => Map<String, String>.from(json.decode(entry)))
        .toList();
  }

  Future<void> saveEntries(List<Map<String, String>> entries) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _storageKey,
      entries.map((entry) => json.encode(entry)).toList(),
    );
  }
}

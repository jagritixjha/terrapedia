import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveCountry({required String countryName}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> saved = pref.getStringList('saved') ?? [];
    saved.add(countryName);
    pref.setStringList('saved', saved);
  }

  static Future<void> removeSaved({required String countryName}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> saved = pref.getStringList('saved') ?? [];
    saved.remove(countryName);
    pref.setStringList('saved', saved);
  }

  static Future<List<String>?> fetchSaved() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> saved = pref.getStringList('saved') ?? [];
    return saved.toSet().toList();
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguageProvider extends ChangeNotifier {
  Locale? _aapLocale;
  Locale? get appLocale => _aapLocale;

  void changeLangauge(Locale type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _aapLocale = type;

    if (type == Locale('en')) {
      await sp.setString('langauge_code', 'en');
    } else {
      await sp.setString('langauge_code', 'fr');
    }
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale;

  LocaleProvider({Locale? initialLocale})
    : _locale = initialLocale ?? const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }

  void toggleLocale() {
    if (_locale.languageCode == 'en') {
      setLocale(const Locale('zh'));
    } else {
      setLocale(const Locale('en'));
    }
  }

  /// Determines the initial locale based on the system locale
  static Locale getInitialLocale(List<Locale> systemLocales) {
    if (systemLocales.isEmpty) return const Locale('en');

    final systemLocale = systemLocales.first;
    if (systemLocale.languageCode == 'zh') {
      return const Locale('zh');
    }
    return const Locale('en');
  }
}

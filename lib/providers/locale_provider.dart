import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// StateNotifier for managing app locale
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier(super.initialLocale);

  void setLocale(Locale locale) {
    if (state == locale) return;
    state = locale;
  }

  void toggleLocale() {
    state = state.languageCode == 'en'
        ? const Locale('zh')
        : const Locale('en');
  }

  /// Determines the initial locale based on system locale
  static Locale getInitialLocale(List<Locale> systemLocales) {
    if (systemLocales.isEmpty) return const Locale('en');
    return systemLocales.first.languageCode == 'zh'
        ? const Locale('zh')
        : const Locale('en');
  }
}

/// Provider for locale state - will be overridden in main.dart with system locale
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier(const Locale('en'));
});

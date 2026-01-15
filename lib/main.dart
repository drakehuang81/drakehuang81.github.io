import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'core/terminal_theme.dart';
import 'core/locale_provider.dart';
import 'screens/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final LocaleProvider _localeProvider;

  @override
  void initState() {
    super.initState();
    final systemLocales = WidgetsBinding.instance.platformDispatcher.locales;
    final initialLocale = LocaleProvider.getInitialLocale(systemLocales);
    _localeProvider = LocaleProvider(initialLocale: initialLocale);
    _localeProvider.addListener(_onLocaleChanged);
  }

  @override
  void dispose() {
    _localeProvider.removeListener(_onLocaleChanged);
    _localeProvider.dispose();
    super.dispose();
  }

  void _onLocaleChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume - Drake Huang',
      debugShowCheckedModeBanner: false,
      theme: TerminalTheme.themeData,
      locale: _localeProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('zh')],
      home: MainPage(localeProvider: _localeProvider),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'l10n/app_localizations.dart';
import 'core/terminal_theme.dart';
import 'providers/locale_provider.dart';
import 'screens/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Get system locale for initial value
  final systemLocales = WidgetsBinding.instance.platformDispatcher.locales;
  final initialLocale = LocaleNotifier.getInitialLocale(systemLocales);

  runApp(
    ProviderScope(
      overrides: [
        // Override with system-detected locale
        localeProvider.overrideWith((ref) => LocaleNotifier(initialLocale)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'Resume - Drake Huang',
      debugShowCheckedModeBanner: false,
      theme: TerminalTheme.themeData,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('zh')],
      home: const MainPage(),
    );
  }
}

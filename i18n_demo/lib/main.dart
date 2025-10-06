import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_demo/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final savedCode = prefs.getString('localeCode'); // e.g. "en"
  runApp(MyApp(initialLocaleCode: savedCode));
}

class MyApp extends StatefulWidget {
  final String? initialLocaleCode;
  const MyApp({super.key, this.initialLocaleCode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    if (widget.initialLocaleCode != null) {
      _locale = Locale(widget.initialLocaleCode!);
    }
  }

  Future<void> _setLocale(Locale locale) async {
    setState(() => _locale = locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('localeCode', locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'i18n Demo',
      locale:
          _locale, // this forces a chosen locale; if null, system locale is used
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: HomePage(onLocaleChanged: _setLocale),
    );
  }
}

class HomePage extends StatelessWidget {
  final Future<void> Function(Locale) onLocaleChanged;
  const HomePage({super.key, required this.onLocaleChanged});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final current = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: LanguageDropdown(
              current: current,
              onSelected: onLocaleChanged,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(loc.greeting, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 12),
            Text(loc.selectLanguage),
          ],
        ),
      ),
    );
  }
}

class LanguageDropdown extends StatelessWidget {
  final Locale current;
  final Future<void> Function(Locale) onSelected;
  const LanguageDropdown({
    super.key,
    required this.current,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // language options shown to the user
    final options = <Map<String, dynamic>>[
      {'locale': const Locale('en'), 'label': 'English'},
      {'locale': const Locale('es'), 'label': 'Español'},
      {'locale': const Locale('fr'), 'label': 'Français'},
      {'locale': const Locale('pt'), 'label': 'Português'},
    ];

    // choose a displayed value that matches the languageCode (ignores region)
    final selected =
        options.firstWhere(
              (o) =>
                  (o['locale'] as Locale).languageCode == current.languageCode,
              orElse: () => options[0],
            )['locale']
            as Locale;

    return DropdownButtonHideUnderline(
      child: DropdownButton<Locale>(
        value: selected,
        icon: const Icon(Icons.language, color: Colors.white),
        onChanged: (Locale? newLocale) {
          if (newLocale != null) {
            onSelected(newLocale);
          }
        },
        items: options.map((opt) {
          final loc = opt['locale'] as Locale;
          return DropdownMenuItem<Locale>(
            value: loc,
            child: Text(opt['label'] as String),
          );
        }).toList(),
      ),
    );
  }
}

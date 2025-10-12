// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Démonstration de langue';

  @override
  String get greeting => 'Bonjour !';

  @override
  String get selectLanguage => 'Choisir une langue';

  @override
  String greetingOnDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Bonjour ! Aujourd\'hui, c\'est $dateString.';
  }
}

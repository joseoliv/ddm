abstract class Translate {
  String get appTitle;
  String get home;

  ///  'home'     loc.home
  String get search;
  String get settings;

  static TranslationPt translationPt = TranslationPt();
  static TranslationEn translationEn = TranslationEn();
  static TranslationFr translationFr = TranslationFr();

  static String defaultLocale = 'en';
  static Translate getTranslation = getTranslationFromLocale(
    Translate.defaultLocale,
  );

  static Translate getTranslationFromLocale(String locale) {
    switch (locale) {
      case 'pt':
        return translationPt;
      case 'fr':
        return translationFr;
      case 'en':
      default:
        return translationEn;
    }
  }
}

class TranslationPt implements Translate {
  @override
  String get appTitle => 'Aplicativo de Exemplo';

  @override
  String get home => 'Início';

  @override
  String get search => 'Pesquisar';

  @override
  String get settings => 'Configurações';
}

class TranslationEn implements Translate {
  @override
  String get appTitle => 'Sample App';

  @override
  String get home => 'Home';

  @override
  String get search => 'Search';

  @override
  String get settings => 'Settings';
}

/// frances
class TranslationFr implements Translate {
  @override
  String get appTitle => 'Application Exemple';

  @override
  String get home => 'Accueil';

  @override
  String get search => 'Chercher';

  @override
  String get settings => 'Paramètres';
}

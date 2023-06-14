import 'package:flutter/material.dart';

import 'constants.dart';

enum SupportedLocales { vi }

extension SupportedLocalesX on SupportedLocales {
  Locale get locale {
    switch (this) {
      case SupportedLocales.vi:
        return const Locale('en');
    }
  }
}

final _mapLanguages = {
  SupportedLocales.vi.locale: LanguageBase(),
};

class L {
  static LanguageBase of(BuildContext context) {
    final _language = Localizations.of<LanguageBase>(context, LanguageBase);

    if (_language != null) return _language;
    throw Exception('No instance language.');
  }

  static AppLocalizationDelegate get delegate => AppLocalizationDelegate();
}

class AppLocalizationDelegate extends LocalizationsDelegate<LanguageBase> {
  AppLocalizationDelegate();

  List<Locale> get supportedLocales => List.from(_mapLanguages.keys);

  bool _isSupported(Locale locale) => _mapLanguages.containsKey(locale);

  Future<LanguageBase> _load(Locale locale) async {
    return _mapLanguages[locale] ?? LanguageBase();
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);

  @override
  Future<LanguageBase> load(Locale locale) => _load(locale);

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}

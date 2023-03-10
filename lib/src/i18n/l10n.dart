import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Localization {
  static final supportedLocales = [
    const Locale('en', ''), //English first, as a fallback

    const Locale('de', ''),
    const Locale('zh', 'Hans'),
  ];

  static String getName(Locale locale) {
    switch (locale.languageCode) {
      case 'de':
        return 'Deutsch';
      case 'zh':
        return '中文';
      case 'en':
      default:
        return 'English';
    }
  }

  static AppLocalizations appLocalizations() => _appLocalizations!;
  static AppLocalizations? _appLocalizations;

  static void init(BuildContext context) =>
      _appLocalizations = AppLocalizations.of(context);
}

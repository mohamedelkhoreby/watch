import 'package:flutter/material.dart';

enum LanguageType { english, arabic }

const String arabic = "ar";
const String english = "en";
const String translationsPath = "assets/translations";

const Locale arabicAS = Locale("ar");
const Locale englishUS = Locale("en");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.arabic:
        return arabic;
    }
  }
}

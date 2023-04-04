// ignore_for_file: file_names

import 'package:get/get.dart';

import 'en_US/en_us_translations.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
      };
}

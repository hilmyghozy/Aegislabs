import 'dart:ui';
import 'package:get/get.dart';
import 'translation/enTranslation.dart';
import 'translation/idTranslation.dart';

class Localizable extends Translations {
  Future<Locale?> getLanguage() async {
    return const Locale('en');
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'id_ID': id,
      };
}

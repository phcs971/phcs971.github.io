import 'package:flutter/cupertino.dart';

class Texts extends ChangeNotifier {
  int _lang = 1;

  // 0 => Ingles
  // 1 => Portugues

  int get lang => _lang;

  void changeLanguage(int newLang) {
    _lang = newLang;
    notifyListeners();
  }

  //                     Exemplo:
  // String get STRING_NAME => [
  //       "TEXT",
  //       "TEXTO",
  //     ][_lang];
}

import 'dart:async';

import 'package:flutter_translator/api/translator_api.dart';

class TranslatorBloc {
  final _controllerText = StreamController<String>();
  Stream<String> get streamTranslator => _controllerText.stream;

  String _text = "";
  String lang = "";
  void translator(String text, bool langEs) async {
    lang = (langEs) ? "en-es" : "es-en";
    print("lang: $lang");
    TranslatorApi api = new TranslatorApi();
    _text = await api.translate("$text", lang);
    print("bloc $_text");
    _controllerText.add(_text);
  }
}

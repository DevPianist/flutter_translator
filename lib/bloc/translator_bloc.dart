import 'dart:async';
import 'package:flutter_translator/util/token.dart';
import 'package:translate/translate.dart';

class TranslatorBloc {
  final _controllerText = StreamController<String>();
  Stream<String> get streamTranslator => _controllerText.stream;

  String lang = "";
  void translator(String text, bool langEs) async {
    lang = (langEs) ? "en-es" : "es-en";
    //detectar idioma
    // DetectIt("${Token.tokenTranslator}").detect(
    //   text,
    //   hint: [
    //     'en',
    //     'de',
    //     'ru',
    //     'hi',
    //   ],
    // ).then(
    //   (data) => print(data),
    //   onError: (e) => print(e),
    // );

    TranslateIt("${Token.tokenTranslator}")
        .translate(
      text ?? ".",
      lang,
    )
        .then(
      (data) {
        _controllerText.add(data["text"]);
        print("bloc: ${data["text"]}");
      },
      onError: (e) => _controllerText.add(text),
    );

    print("lang: $lang");
  }
}

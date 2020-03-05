import 'dart:async';
import 'package:flutter_translator/util/token.dart';
import 'package:translate/translate.dart';
import 'package:translator/translator.dart';

class TranslatorBloc {
  String _fromLang;
  String _toLang;
  String _google;
  TranslatorBloc() {
    _fromLang = "es";
    _toLang = "en";
    _google = "";
  }
  final _controllerText = StreamController<String>();
  Stream<String> get streamTranslator => _controllerText.stream;

  final _controllerFromLang = StreamController<String>();
  Stream<String> get streamFromLang => _controllerFromLang.stream;

  final _controllerToLang = StreamController<String>();
  Stream<String> get streamToLang => _controllerToLang.stream;

  final _controllerCurrentText = StreamController<String>();
  Stream<String> get streamCurrentText => _controllerCurrentText.stream;

  void translator(String text) async {
    if (text == "Escribiendo...") {
      _controllerText.add(text);
    } else if (text == "" || text.isEmpty) {
      _controllerText.add("");
    } else {
      print(text);
      _controllerText.add("Traduciendo...");
      print("lang: $_fromLang-$_toLang");
      final translator = GoogleTranslator();
      _google =
          await translator.translate(text, from: '$_fromLang', to: '$_toLang');
      // Map<String, String> data = await TranslateIt("${Token.tokenTranslator}")
      //     .translate(text ?? ".", "$_fromLang-$_toLang");
      _controllerText.add(_google);
      // if (data.isNotEmpty) {
      //   _controllerText.add(data["text"]);
      //   print("bloc: ${data["text"]}");
      // } else {
      //   print("bloc: Empty");
      //   _controllerText.add("");
      // }
    }
  }

  void fromLang(String fromLang) {
    _fromLang = fromLang;
    _controllerFromLang.add(fromLang);
  }

  void toLang(String toLang) {
    _toLang = toLang;
    _controllerToLang.add(toLang);
  }

  void currentText(String currentText) {
    _controllerCurrentText.add(currentText);
  }
}

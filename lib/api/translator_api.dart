import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_translator/models/translator_model.dart';
import 'package:http/http.dart' as http;
import '../util/app_config.dart';
import '../util/token.dart';

class TranslatorApi {
  Future<String> translate(String text, String lang) async {
    try {
      final url =
          "${AppConfig.apiHost}?key=${Token.tokenTranslator}&text=$text&lang=$lang";
      final response = await http.get(url);

      final parsed = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return TranslatorModel.fromJson(parsed).translated;
      } else if (response.statusCode == 509) {
        throw PlatformException(code: "509", message: parsed['message']);
      }
      throw PlatformException(code: "509", message: "Error /translator");
    } on PlatformException catch (e) {
      print(e.message);
      return "No se encontro traduccion";
    }
  }
}

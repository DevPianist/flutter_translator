class TranslatorModel {
  final String translated;

  TranslatorModel({this.translated});

  factory TranslatorModel.fromJson(Map<String, dynamic> json) {
    return TranslatorModel(
      translated: json["text"][0] ?? "No se encontró traduccion",
    );
  }
}

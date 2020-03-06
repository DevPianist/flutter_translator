import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../blocs/translator_bloc.dart';
import '../../../ui/widgets/home/result_card.dart';
import '../../../util/responsive.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamController<String> _streamWritingController = StreamController();
  bool change;
  bool translating;
  String fromLang;
  String toLang;
  final translatorBLoC = TranslatorBloc();
  Responsive _size;
  Stream<String> a;

  @override
  void initState() {
    translating = false;
    final debounce = StreamTransformer<String, String>.fromBind(
        (s) => s.debounce(const Duration(milliseconds: 350)));

    debounce.bind(_streamWritingController.stream).listen((s) {
      print("entro!! $s");
      translating = true;
      _translator(s);
    });

    _size = new Responsive(context);
    change = false;
    fromLang = "es";
    toLang = "en";
    super.initState();
  }

  _translator(text) {
    if (translating) {
      translatorBLoC.translator(text);
    } else {
      translatorBLoC.translator("");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build");

    FlatButton _changeLang = FlatButton(
      splashColor: Colors.grey[200],
      color: Colors.indigo,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1000.0),
      ),
      child: Icon(
        Icons.autorenew,
        color: Colors.white,
      ),
      onPressed: () {
        String aux = fromLang;
        fromLang = toLang;
        toLang = aux;
        translatorBLoC.fromLang(fromLang);
        translatorBLoC.toLang(toLang);
      },
    );
    Container inputText = Container(
      padding: const EdgeInsets.all(25.0),
      child: TextField(
        textAlign: TextAlign.justify,
        minLines: 1,
        maxLines: 6,
        textCapitalization: TextCapitalization.sentences,
        onChanged: (string) {
          print(string);
          print(string.length.toString());
          if (string.length == 1) {
            translating = false;
            translatorBLoC.translator("Escribiendo...");
          } else if (string.length == 0) {
            translating = false;
            translatorBLoC.translator("");
          }
          _streamWritingController.add(string);
        },
        onSubmitted: (string) {
          translatorBLoC.translator(string);
        },
        autocorrect: false,
        style: TextStyle(fontSize: 16.0),
        maxLength: 200,
        decoration: InputDecoration.collapsed(hintText: "Ingresa una palabra"),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: CupertinoButton(
                    child: StreamBuilder<String>(
                      stream: translatorBLoC.streamFromLang,
                      initialData: "",
                      builder: (context, snapshot) {
                        return Text(
                          (snapshot.data == "en") ? "Ingles" : "Español",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        );
                      },
                    ),
                    onPressed: () => print(change ? "Ingles" : "Español"),
                  ),
                ),
                Container(
                  width: _size.width() * 0.15,
                  height: _size.height() * 0.04,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(1000.0),
                  ),
                  child: _changeLang,
                ),
                Expanded(
                  child: CupertinoButton(
                    child: StreamBuilder<String>(
                      stream: translatorBLoC.streamToLang,
                      initialData: "",
                      builder: (context, snapshot) {
                        return Text(
                          (snapshot.data == "es") ? "Español" : "Inglés",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        );
                      },
                    ),
                    onPressed: () => print(change ? "Ingles" : "Español"),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: _size.height() * 0.03,
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Stack(
              children: <Widget>[
                inputText,
              ],
            ),
          ),
          SizedBox(
            height: _size.height() * 0.01,
          ),
          ResultStream(stream: translatorBLoC.streamTranslator)
        ],
      ),
    );
  }
}

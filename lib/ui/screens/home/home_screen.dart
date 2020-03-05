import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translator/blocs/translator_bloc.dart';
import 'package:flutter_translator/ui/widgets/home/current_text_stream.dart';
import 'package:flutter_translator/ui/widgets/home/result_card.dart';
import 'package:flutter_translator/util/responsive.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool change;
  String fromLang;
  String toLang;
  String currentText;
  final translatorBLoC = TranslatorBloc();
  // TextEditingController textController;
  Size _size;

  @override
  void initState() {
    currentText = "";

    // textController = new TextEditingController();
    _size = new Size(context);
    change = false;
    fromLang = "es";
    toLang = "en";
    super.initState();
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
        textCapitalization: TextCapitalization.sentences,
        // controller: textController,
        onChanged: (string) {
          currentText = string;
          (string != "")
              ? translatorBLoC.translator("Escribiendo...")
              : translatorBLoC.translator("");
          translatorBLoC.currentText(currentText);
        },
        autocorrect: false,
        style: TextStyle(fontSize: 16.0),
        maxLength: 200,
        decoration: InputDecoration.collapsed(hintText: "Ingresa una palabra"),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Traductor flutter"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
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
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: IconButton(
                        color: Colors.indigo,
                        splashColor: Colors.indigo,
                        icon: Icon(Icons.send),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          translatorBLoC.translator(currentText);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _size.height() * 0.01,
              ),
              // CurrentTextStream(
              //     text: currentText, stream: translatorBLoC.streamCurrentText),
              ResultStream(stream: translatorBLoC.streamTranslator)
            ],
          ),
        ),
      ),
    );
  }
}

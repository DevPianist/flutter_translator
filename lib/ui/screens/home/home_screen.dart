import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translator/bloc/translator_bloc.dart';
import 'package:flutter_translator/ui/widgets/home/current_text.dart';
import 'package:flutter_translator/ui/widgets/home/result_card.dart';
import 'package:flutter_translator/util/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool langEs = false;
  bool translator = false;
  TextEditingController textController;
  final streamsBLoC = TranslatorBloc();
  String translated = "";
  String currentText = "";
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    final Size _size = new Size(context);
    textController = new TextEditingController();
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
        langEs = !langEs;
        setState(() {});
      },
    );
    Container inputText = Container(
      padding: const EdgeInsets.all(25.0),
      child: TextField(
        controller: textController,
        onChanged: (string) {
          currentText = string;
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
                        child: Text(
                          langEs ? "Ingles" : "Español",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        onPressed: () => print(langEs ? "Ingles" : "Español"),
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
                        child: Text(
                          langEs ? "Español" : "Ingles",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        onPressed: () => print(langEs ? "Español" : "Ingles"),
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
                          if (!translator) {
                            setState(() {});
                            translator = true;
                          }
                          if (currentText != "")
                            streamsBLoC.translator(currentText, langEs);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _size.height() * 0.01,
              ),
              (translator && currentText != "")
                  ? CurrentText(text: currentText)
                  : Container(),
              (translator && currentText != "")
                  ? ResultStream(stream: streamsBLoC.streamTranslator)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

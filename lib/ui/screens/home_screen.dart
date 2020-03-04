import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translator/bloc/translator_bloc.dart';
import 'package:flutter_translator/util/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool langEs = false;
  bool translator = false;
  TextEditingController textController = TextEditingController(text: "");
  final streamsBLoC = TranslatorBloc();

  @override
  Widget build(BuildContext context) {
    final Size _size = new Size(context);
    StreamBuilder<String> result = StreamBuilder<String>(
      stream: streamsBLoC.streamTranslator,
      initialData: "",
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null && snapshot.data != "") {
          return Card(
            margin: const EdgeInsets.all(15.0),
            color: Colors.indigo,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(25.0),
                  width: _size.width(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: _size.height() * 0.15,
                    ),
                    child: Text(
                      "${snapshot.data}",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          );
        }
        return CupertinoActivityIndicator();
      },
    );
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Traductor flutter"),
      ),
      body: SingleChildScrollView(
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
              height: _size.height() * 0.01,
            ),
            Card(
              margin: const EdgeInsets.all(15.0),
              color: Colors.grey[200],
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(25.0),
                    child: TextField(
                      style: TextStyle(fontSize: 16.0),
                      autocorrect: false,
                      controller: textController,
                      maxLength: 200,
                      maxLines: 3,
                      decoration: InputDecoration.collapsed(
                          hintText: "Ingresa una palabra"),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: IconButton(
                      color: Colors.indigo,
                      splashColor: Colors.indigo,
                      icon: Icon(Icons.send),
                      onPressed: () {
                        if (!translator) setState(() {});
                        translator = true;
                        streamsBLoC.translator(textController.text, langEs);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _size.height() * 0.01,
            ),
            (translator && textController.text != "") ? result : Container(),
          ],
        ),
      ),
    );
  }
}

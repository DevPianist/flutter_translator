import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translator/util/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool change = false;
  bool translator = false;
  TextEditingController textController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final Size _size = new Size(context);
    Card result = Card(
      margin: const EdgeInsets.all(15.0),
      color: Colors.indigo,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(25.0),
            width: _size.width(),
            height: _size.height() * 0.2,
            child: Text(
              "${textController.text}",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
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
        change = !change;
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
                        change ? "Ingles" : "Español",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      onPressed: () {},
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
                        change ? "Español" : "Ingles",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      onPressed: () {},
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
                        translator = true;
                        setState(() {});
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

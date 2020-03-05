import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translator/util/responsive.dart';

class CurrentTextStream extends StatelessWidget {
  final text;
  final stream;
  const CurrentTextStream({Key key, this.text, this.stream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = new Size(context);
    return StreamBuilder<String>(
      stream: stream,
      initialData: "",
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null && snapshot.data != "") {
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            width: _size.width(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: _size.height() * 0.01,
              ),
              child: Text(
                "$text",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

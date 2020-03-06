import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../util/responsive.dart';
import 'package:share/share.dart';

class ResultStream extends StatelessWidget {
  final Stream<String> stream;

  const ResultStream({Key key, this.stream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive _size = new Responsive(context);
    return StreamBuilder<String>(
      stream: stream,
      initialData: "",
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null && snapshot.data != "") {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.justify,
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
                    onPressed: snapshot.data != ""
                        ? () => Share.share(snapshot.data)
                        : null,
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

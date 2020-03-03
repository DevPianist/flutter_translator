import 'package:flutter/material.dart';

class Size {
  final BuildContext context;

  Size(this.context);
  double width() {
    return MediaQuery.of(context).size.width;
  }

  double height() {
    return MediaQuery.of(context).size.height;
  }
}

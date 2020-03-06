import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);
  double width() {
    return MediaQuery.of(context).size.width;
  }

  double height() {
    return MediaQuery.of(context).size.height;
  }
}

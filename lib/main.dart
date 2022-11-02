import 'package:flutter/material.dart';
import 'package:crud_lista_compras/views/home_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(), //HomePage está declarada em lib/views/home_page.dart
    theme: ThemeData(primarySwatch: Colors.lightBlue),
  ));
}

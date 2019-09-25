import 'package:flutter/material.dart';
import 'calender.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '学校給食アプリ',
      home: calender(),
      routes: <String, WidgetBuilder> {
        '/calender': (BuildContext context) => new calender(),
        '/details': (BuildContext context) => new details(),
      },
    );
  }
}
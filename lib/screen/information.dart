import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart' as menu;
import 'package:sample/data/child.dart' as child;

/* インフォメーション画面 */
class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'このアプリについて',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                height: 3.0,
                fontSize: 22,
              ),
            ),
            Text(
              '　函館市で提供されているオープンデータと、函館市の小中学校からいただいたデータを使っています。',
              style: TextStyle(
                height: 1.0,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}

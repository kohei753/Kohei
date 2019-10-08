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
        title: Text('インフォメーション'), // タイトル
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'このアプリについて',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                height: 2.0,
                fontSize: 22,
              ),
            ),
            Text(
              '　オープンデータと函館市の小中学校からいただいたデータを使っています。',
              style: TextStyle(
                height: 1.0,
                fontSize: 18,
              ),
            ),
            Text(
              '使っているオープンデータ',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 2.0,
                fontSize: 20,
              ),
            ),
            Text(
              '・函館の給食の放射能検査について''https://www.city.hakodate.hokkaido.jp/docs/2014031600182/',
              style: TextStyle(
                height: 1.0,
                fontSize: 18,
              ),
            ),
            Text(
              '・函館の給食の原産地について''https://www.city.hakodate.hokkaido.jp/docs/2014031600120/',
              style: TextStyle(
                height: 1.0,
                fontSize: 18,
              ),
            ),
            Text(
              '・もうちょっと',
              style: TextStyle(
                height: 1.0,
                fontSize: 18,
              ),
            ),
            Text(
              '製作者の連絡先',
              style: TextStyle(
                height: 2.0,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

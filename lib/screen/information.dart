import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

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
        child: SingleChildScrollView(
          child: Column(
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
                '・函館の給食の放射能検査について\n''https://www.city.hakodate.hokkaido.jp/docs/2014031600182/\n'
                    '・函館の給食の原産地について\n''https://www.city.hakodate.hokkaido.jp/docs/2014031600120/\n'
                    '・函館市の学校給食　簡単メニュー紹介\n''https://www.city.hakodate.hokkaido.jp/docs/2016012500108/\n',
                style: TextStyle(
                  //height: 1.0,
                  fontSize: 18,
                ),
              ),
              Text(
                '製作者の連絡先',
                style: TextStyle(
                  height: 2.0,
                  fontSize: 20,
                ),
              ),
              Text(
                'xxx@xxx.jp',
                style: TextStyle(
                  height: 1.0,
                  fontSize: 18,
                ),
              ),
              Text(
                '協力してくださった方',
                style: TextStyle(
                  height: 2.0,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

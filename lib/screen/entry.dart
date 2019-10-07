import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart' as child;
import 'home.dart';

/* 初期登録画面 */
class Entry extends StatefulWidget {
  final Map<DateTime, Menu> menus;
  Entry({Key key, this.menus}) : super(key: key);

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  Map<DateTime, Menu> menus;  // JSONから取得したメニュー情報(この画面では使わないが、次の画面に引き渡すために必要)
  child.Child myChild = child.Child('太郎', '函館中学校', 7, 0); // 登録情報

  /* 入力情報を登録 */
  void entryInfo() {
    // TODO: 入力された情報を記録する関数
    child.writeInfo(myChild);
    menus = widget.menus;
    handleToHome();
  }

  /* ホーム画面への遷移 */
  void handleToHome() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/home'),
          builder: (BuildContext context) => Home(menus: menus, child: myChild),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('登録'),
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.check),
        onPressed: entryInfo,
      ),
    );
  }
}

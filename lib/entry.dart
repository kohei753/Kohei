import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'menu.dart' as menus;
import 'child.dart' as child;

/* 初期登録画面 */
class Entry extends StatefulWidget {
  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  /* 入力情報を登録 */
  void entryInfo() {
    // TODO: 入力された情報を記録する関数
    child.writeInfo(child.Child('太郎', '函館中学校', 7, 'men'));
    handleToHome();
  }

  /* ホーム画面への遷移 */
  void handleToHome() {
    Navigator.pushReplacementNamed(context, '/home');
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
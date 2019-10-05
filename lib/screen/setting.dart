import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'home.dart';
import 'origin.dart';
import 'information.dart';
import 'help.dart';

/* 設定画面 */
class Setting extends StatefulWidget {
  final Child child;
  Setting({Key key, this.child}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Child child;

  /* 各遷移先へのキー＆表示 */
  static const String origin = '原産地';
  static const String info = 'このアプリについて';
  static const String help = 'ヘルプ';

  List<Widget> _itemList = []; // 表示するリスト

  @override
  void initState() {
    super.initState();
    child = widget.child;

    _itemList = [
      _buildEntryTile(),  // 登録情報
      _buildTile(origin, Icon(Icons.location_on)),  // 原産地
      _buildTile(info, Icon(Icons.info)), // インフォ
      _buildTile(help, Icon(Icons.help)), // ヘルプ
    ];
  }

  /* リストタイルの遷移先への遷移 */
  void handleToKey(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: '/$title'),
        builder: (BuildContext context) => nextWidget(title), // 遷移先をtitleによって変える
      ),
    );
  }

  /* 遷移先を判定 */
  Widget nextWidget(String title) {
    switch (title) {
      // 原産地画面へ
      case origin:
        return Origin();
        break;
      // インフォメーション画面へ
      case info:
        return Information();
        break;
      // ヘルプ画面へ
      case help:
        return Help();
        break;
      // 何らかのエラーの場合はホームに戻る
      default:
        return Home();
    }
  }

  /* 登録情報タイル生成 */
  Widget _buildEntryTile() {
    return Container(
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
        leading: Container(
          child: Icon(  // 人のアイコン
            Icons.person,
            size: 50,
            color: Colors.white,
          ),
          decoration: BoxDecoration(  // アイコン丸で囲みたかった
            shape: BoxShape.circle,
            color: Colors.black26,
          ),
        ),
        title: Text(
          '登録情報',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        subtitle: Text('巴中学校'),
        trailing: Icon(Icons.keyboard_arrow_right), // 右端の矢印
        onTap: () {},
      ),
    );
  }

  /* 登録情報以外のタイルの生成
   * 汎用的なリスト表示でコードの重複を避ける */
  Widget _buildTile(String title, Icon icon) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: icon,
        title: Text(title),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () => handleToKey(title),  // 各画面への遷移
        dense: true,  // 余白を詰める
      ),
    );
  }

  /* ボディのリスト生成 */
  Widget _buildBodyList() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: _itemList.length,
      itemBuilder: (BuildContext context, int index) {
        return _itemList[index];
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
      ),
      body: _buildBodyList(),
    );
  }
}

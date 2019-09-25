import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';

/* 詳細画面 */
class Detail extends StatefulWidget {
  final Map<DateTime, Menu> menus;
  final Child child;
  Detail({Key key, this.menus, this.child}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  /* 献立データ */
  var dailyMenu = {};

  /* カラーリスト */
  Map<String, Color> _detailColors = {
    'deRed': Color(0xFFE06777),
    'deBlue': Color(0xFF67a8e0),
    'deYellow': Color(0xFFd8e067),
    'dePurple': Color(0xFFb867e0),
    'deGreen': Color(0xFF67e088),
  };

  /* サイドメニューを生成 */
  Widget _buildDrawer() {
    return Drawer(
      child: ListView.builder(
        // 中身はリスト表示
        padding: EdgeInsets.zero,
        itemCount: dailyMenu.length,
        itemBuilder: (context, i) {},
//        children: <Widget>[
//          DrawerHeader(
//            // ヘッダー
//            child: Text('選択中の料理'),
//            decoration: BoxDecoration(
//              color: _detailColors['deRed'],
//            ),
//          ),
//        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('料理名'),
      ),
      endDrawer: _buildDrawer(), // サイドメニュー
    );
  }
}

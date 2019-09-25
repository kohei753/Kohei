import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart';
import 'package:sample/data/dish.dart';
import 'package:sample/data/child.dart';

/* 詳細画面 */
class Detail extends StatefulWidget {
  final Menu dailyMenu;

  final Child child;
  Detail({Key key, this.dailyMenu, this.child}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  /* 献立データ */
  Menu _dailyMenu; // 表示する日のメニューデータ

  /* サイドバー関係 */
  int _selectedIndex = 0; // 選択中のタブ番号管理

  /* カラーリスト */
  List<Color> _detailColors = [
    Colors.deepOrangeAccent,
    Color(0xFFE06777),
    Color(0xFF67e088),
    Color(0xFFd8e067),
    Color(0xFF67a8e0),
    Color(0xFFb867e0),
  ];

  /* 読み込まれた時にデータを取得する */
  @override
  void initState() {
    super.initState();
    _dailyMenu = widget.dailyMenu;
  }

  /* サイドメニューを生成 */
  Widget _buildDrawer() {
    return Drawer(
      child: ListView.builder(
        // 中身はリスト表示
        padding: EdgeInsets.zero,
        itemCount: _dailyMenu.menu.length,
        itemBuilder: (context, i) {
          if (i == _selectedIndex) return _buildDrawerHeader(_dailyMenu.menu[i]);
          return Container(
            color: _detailColors[i],
            child: ListTile(
              title: Text(_dailyMenu.menu[i].name),
            ),
          );
        },
      ),
    );
  }

  /* 選択中のサイドメニュー */
  Widget _buildDrawerHeader(Dish dish) {
    return DrawerHeader(
      child: Text(dish.name),
      decoration: BoxDecoration(
        color: _detailColors[_selectedIndex],
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

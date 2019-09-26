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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /* サイドメニューを生成 */
  Widget _buildDrawer() {
    return Drawer(
      child: ListView.builder(
        // 中身はリスト表示
        padding: EdgeInsets.zero, // 余白を消去
        itemCount: _dailyMenu.menu.length + 1,  // +1はヘッダーを作成するため
        itemBuilder: (context, i) {
          if (i == 0) return _buildDrawerHeader();  // 一番上にヘッダーを作成
          final index = i - 1; // ヘッダーを抜いた真実のindex
          return Container(
            color: _detailColors[index],  // 色変えてるけどダセェから多分変える
            child: ListTile(
              title: Text(_dailyMenu.menu[index].name), // とりあえず名前だしてるだけ
              onTap: () => _onItemTapped(index),  // タップしたら切り替えるように
            ),
          );
        },
      ),
    );
  }

  /* 選択中のサイドメニュー */
  Widget _buildDrawerHeader() {
    return DrawerHeader(
      child: Text(_dailyMenu.day.toIso8601String()),  // 今は日付とかだしてるだけ
      decoration: BoxDecoration(
        color: _detailColors[_selectedIndex], // 色も変えられるよ
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(_dailyMenu.menu[_selectedIndex].name),  // 選択した料理名に
        backgroundColor: _detailColors[_selectedIndex],
      ),
      endDrawer: _buildDrawer(), // サイドメニュー
    );
  }
}

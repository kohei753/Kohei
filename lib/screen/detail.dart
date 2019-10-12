import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:intl/intl.dart';  // DateTimeのフォーマットに使う

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/data/dri.dart';

/* 詳細画面 */
class Detail extends StatefulWidget {
  final Menu dailyMenu;
  final Child child;
  final DRI dri;
  final int menuNum;  // 選択されたメニューの番号
  Detail({Key key, this.dailyMenu, this.child, this.dri, this.menuNum}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  /* 諸々データ */
  Menu _dailyMenu; // 表示する日のメニューデータ
  Child child;
  DRI dri;
  var formatter = DateFormat("yyyy/MM/dd(E)"); // 日付をフォーマットするやつ

  /* サイドバー関係 */
  int _selectedIndex = 0; // 選択中のタブ番号管理

  /* カラーリスト */
  List<Color> _detailColors = [
    Color(0xFFf6f183),
    Color(0xFF82c1f5),
    Color(0xFF87f582),
    Color(0xFFf58287),
    Color(0xFFffba66),
    Color(0xFFb682f5),
  ];

  /* サイドバーの各メニューのアイコン
  *  色が上のカラーリストと対応している */
  List<String> _menuIcon = [
    'assets/staple.png',
    'assets/drink.png',
    'assets/side_green.png',
    'assets/side_red.png',
    'assets/side_orenge.png',
    'assets/side_purple.png',
  ];

  /* 読み込まれた時にデータを取得する */
  @override
  void initState() {
    super.initState();
    _dailyMenu = widget.dailyMenu;
    child = widget.child;
    dri = widget.dri;
    if (widget.menuNum != null) _selectedIndex = widget.menuNum;
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
        itemCount: _dailyMenu.menu.length + 1, // +1はヘッダーを作成するため
        itemBuilder: (context, i) {
          if (i == 0) return _buildDrawerHeader(); // 一番上にヘッダーを作成
          final index = i - 1; // ヘッダーを抜いた真のindex
          return ListTile(
            leading: Image.asset(
              // メニューの横のアイコン
              _menuIcon[index],
              width: 50,
              height: 50,
            ),
            title: Text(_dailyMenu.menu[index].name), // とりあえず名前だしてるだけ
            onTap: () => _onItemTapped(index), // タップしたら切り替えるように
          );
        },
      ),
    );
  }

  /* サイドメニューのヘッダー */
  Widget _buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text(
        // メニュー名
        _dailyMenu.menu[_selectedIndex].name,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 20, // ちょっと大きめに
        ),
      ),
      accountEmail: Text(
        // 日付
        formatter.format(_dailyMenu.day),
        style: TextStyle(
          color: Colors.black54,
          fontSize: 15,
        ),
      ),
      currentAccountPicture: CircleAvatar(
        // 画像
        backgroundColor: Colors.black26,
        child: Image.asset(_menuIcon[_selectedIndex]),
      ),
      decoration: BoxDecoration(
        color: _detailColors[_selectedIndex], // 背景色も変えられるよ
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _dailyMenu.menu[_selectedIndex].name,
          style: TextStyle(color: Colors.black54),
        ), // 選択した料理名に
        backgroundColor: _detailColors[_selectedIndex],
      ),
      endDrawer: _buildDrawer(), // サイドメニュー
    );
  }
}

import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart' as menus;
import 'package:sample/data/child.dart' as child;
import 'package:sample/screen/dailyMenu.dart';
import 'package:sample/screen/monthlyMenu.dart';
import 'package:sample/screen/setting.dart';

/* ホーム画面 */
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _title = '日付';
  /* BottomNavigationBarで使用する諸々 */
  int _selectedIndex = 0; // 選択中のタブ番号を管理
  List<Widget> _widgetOptions = <Widget>[
    DailyMenu(),  // 1日の献立画面
    MonthlyMenu(),  // 献立表画面
  ];

  void _onItemTapped(int index) {
    // メニューがタップされた時更新
    setState(() {
      _selectedIndex = index;
      _title = (index != 0) ? 'X月の献立表' : '日付';
    });
  }

  void _handleSetting() {
    // 設定画面へ
    Navigator.push(
        context,
        MaterialPageRoute<Null>(
          settings: RouteSettings(name: '/setting'),
          builder: (BuildContext context) => Setting(),
          fullscreenDialog: true, // モーダルで表示
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title), // TODO:表示したい日付に変わる予定
        actions: <Widget>[
          // 設定ボタン
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _handleSetting, // 設定画面に遷移
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex), // ListになってるWidgetを読み込む
      bottomNavigationBar: BottomNavigationBar(
        // タブバーの実装
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // 1日の献立を表示する画面に遷移するアイコン
            icon: Icon(
              Icons.view_list,
              size: 30,
            ),
            title: Text('献立'),
          ),
          BottomNavigationBarItem(
            // 献立表を表示する画面に遷移するアイコン
            icon: Icon(
              Icons.calendar_today,
              size: 30,
            ),
            title: Text('献立表'),
          ),
        ],
        currentIndex: _selectedIndex, // 選択中の画面を管理
        selectedItemColor: Colors.deepOrangeAccent, // 選択時の色
        onTap: _onItemTapped, // タップすると更新
      ),
    );
  }
}
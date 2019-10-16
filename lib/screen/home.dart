import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:intl/intl.dart';  // 型変形

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/data/dri.dart';
import 'package:sample/screen/dailyMenu.dart';
import 'package:sample/screen/monthlyMenu.dart';
import 'package:sample/screen/setting.dart';
import 'package:sample/data/strings.dart';

/* ホーム画面 */
class Home extends StatefulWidget {
  final Map<DateTime, Menu> menus;
  final Child child;
  final DRI dri;
  final DateTime selectDay;  // 指定がなければ今日
  Home({Key key, this.menus, this.child, this.dri, this.selectDay}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /* 引き継いだ情報 */
  Map<DateTime, Menu> menus;
  Child child;
  DRI dri;
  DateTime selectDay;

  String _title;

  /* BottomNavigationBarで使用する諸々 */
  List<Widget> _widgetOptions;  // タブのリスト
  int _selectedIndex = 0; // 選択中のタブ番号を管理

  /* 初期化処理 */
  @override
  void initState() {
    super.initState();
    /* 引き継いだ情報の取得 */
    menus = widget.menus;
    child = widget.child;
    dri = widget.dri;
    // selectDay = widget.selectDay;
    selectDay = DateTime(2019, 8, 19);

    _title = DateFormat("MM月dd日").format(selectDay);

    /* widgetリストの中身作成 */
    _widgetOptions = [
      DailyMenu(menu: menus[DateTime(selectDay.year, selectDay.month, selectDay.day)], child: child, dri: dri),
      MonthlyMenu(menus: menus, child: child, dri: dri),
    ];
  }

  void _onItemTapped(int index) {
    // メニューがタップされた時更新
    setState(() {
      _selectedIndex = index;
      _title = (index != 0) ? '${selectDay.month}月の献立表' : DateFormat("MM月dd日").format(selectDay);
    });
  }

  void handleToSetting() {
    // 設定画面へ
    Navigator.push(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/setting'),
          builder: (BuildContext context) => Setting(child: child),
          fullscreenDialog: true, // モーダルで表示
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          // 設定ボタン
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: handleToSetting, // 設定画面に遷移
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
        selectedItemColor: Theme.of(context).primaryColor, // 選択時の色
        onTap: _onItemTapped, // タップすると更新
      ),
    );
  }
}
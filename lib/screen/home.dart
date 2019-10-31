import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:intl/intl.dart'; // 型変形

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/data/dri.dart';
import 'package:sample/data/slis.dart';
import 'package:sample/screen/dailyMenu.dart';
import 'package:sample/screen/monthlyMenu.dart';
import 'package:sample/screen/setting.dart';

/* ホーム画面 */
class Home extends StatefulWidget {
  final Map<DateTime, Menu> menus;
  final Child child;
  final DRI dri;
  final SLIS slis;
  final DateTime selectDay; // 指定がなければ今日
  Home({Key key, this.menus, this.child, this.dri, this.slis, this.selectDay})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState(menus, child, dri, slis, selectDay);
}

class _HomeState extends State<Home> {
  /* 引き継いだ情報 */
  final Map<DateTime, Menu> menus;
  final Child child;
  final DRI dri;
  final SLIS slis;
  final DateTime selectDay;
  _HomeState(this.menus, this.child, this.dri, this.slis, this.selectDay);

  String _title;  // AppBarのテキスト

  /* BottomNavigationBarで使用する諸々 */
  List<Widget> _widgetOptions; // タブのリスト
  int _selectedIndex = 0; // 選択中のタブ番号を管理

  /* 初期化処理 */
  @override
  void initState() {
    super.initState();

    _title = DateFormat("MM月dd日").format(selectDay);

    /* widgetリストの中身作成 */
    _widgetOptions = [
      DailyMenu(
          menu: menus[DateTime(selectDay.year, selectDay.month, selectDay.day)],
          child: child,
          dri: dri,
          slis: slis),
      MonthlyMenu(menus: menus, child: child, dri: dri, slis: slis, selectedDay: selectDay),
    ];
  }

  void _onItemTapped(int index) {
    // メニューがタップされた時更新
    setState(() {
      _selectedIndex = index;
      _title = (index != 0)
          ? '${selectDay.month}月の献立表'
          : DateFormat("MM月dd日").format(selectDay);
    });
  }

  void handleToSetting() async {
    // 設定画面へ
    await Navigator.push(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/setting'),
          builder: (BuildContext context) => Setting(child: child),
          fullscreenDialog: true, // モーダルで表示
        ));
    // 登録情報に更新があった場合はリロード
    Child newChild = await readInfo();
    if (child.name != newChild.name ||
        child.sex != newChild.sex ||
        child.school != newChild.school ||
        child.schoolYear != newChild.schoolYear) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            settings: RouteSettings(name: '/reHome'),
            builder: (BuildContext context) => Home(
                menus: menus, child: newChild, dri: dri, slis: slis, selectDay: selectDay),
          ));
    }
  }

  /* 下のメニューバー */
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      // タブバーの実装
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          // 1日の献立を表示する画面に遷移するアイコン
          icon: Icon(
            Icons.local_dining,
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
    );
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
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

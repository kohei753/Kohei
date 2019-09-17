import 'dart:async';  // 非同期処理関係

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart'; // イベントクラスに関するやーつ
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel; // 献立表のカレンダーに関するAPI

import 'menu.dart' as menus;

void main() {
  runApp(MaterialApp(
    title: '給食アプリ(仮)',
    theme: ThemeData(
      primaryColor: Colors.deepOrangeAccent,
    ),
    /* 画面遷移スタックを名前で管理する */
    home: Splash(), // スプラッシュ
    routes: <String, WidgetBuilder>{
      '/entry': (BuildContext context) => Entry(), // 初回起動時にのみ表示される画面
      '/home': (BuildContext context) => Home(), // 1日の献立を表示する画面
      '/detail': (BuildContext context) => Detail(), // 各料理の詳細画面を表示する画面
      '/monthly-menu': (BuildContext context) => MonthlyMenu(), // 献立表を表示する画面
      '/setting': (BuildContext context) => Setting(), // 設定画面
      '/information': (BuildContext context) => Information(), // データ元などのインフォ画面
    },
  ));
}

/* スプラッシュ画面 */
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  /* スプラッシュ中の処理
   * ネイティブでやった方が綺麗だし、本来の意味のスプラッシュとして
   * 利用できると思うが、ここで多分初期情報とかを読み込むと思うから
   * それをネイティブからやるの難しそうだったのでとりあえすここに書いてる */
  static var allMenu = {};  // jsonのメニューを格納する変数

  @override
  void initState() {
    // 最初に読み込まれる
    super.initState();

    // 献立データを取得 => value
    menus.getMenus().then((value) {
      allMenu = value;
      print("読み込めてるかーな"); // ok!
      // TODO: 各画面に読み込んだデータを受け渡しつつ遷移
      handleTimeout();
    });
  }

  /* スプラッシュで表示するアイコンだとかの処理はここ */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlutterLogo();
  }

  /* タイムアウトした後の処理
   * 今回はとりあえずホーム画面に移動させてる */
  void handleTimeout() {
    // ホーム画面へ
    Navigator.pushReplacementNamed(context, '/home');
  }
}

/* 初期登録画面 */
class Entry extends StatefulWidget {
  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

/* ホーム画面 */
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _title = '日付';
  /* BottomNavigationBarで使用する諸々 */
  int _selectedIndex = 0; // 選択中のタブ番号を管理
  static const List<Widget> _widgetOptions = <Widget>[
    /* TODO:ここに今日の献立の画面と献立表の画面のウィジェットをうまく管理する */
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: 献立表',
    ),
  ];

  void _onItemTapped(int index) {
    // メニューがタップされた時更新
    setState(() {
      _selectedIndex = index;
      _title = (index != 0) ? 'X月の献立表' : '日付';
    });
  }

  /* 1日の献立画面のウィジェット */
  Widget _buildHome() {
    return null;
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

/* 詳細画面 */
class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

/* 献立表画面 */
class MonthlyMenu extends StatefulWidget {
  @override
  _MonthlyMenuState createState() => _MonthlyMenuState();
}

class _MonthlyMenuState extends State<MonthlyMenu> {
  /* カレンダー部分の変数 */
  DateTime _currentDate = DateTime.now();

  /* カレンダーの更新用 */
  void onDayPressed(DateTime date, List<Event> events) {
    this.setState(() => _currentDate = date);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: CalendarCarousel<Event>(
          onDayPressed: onDayPressed, // 日にちが選択された時の処理
          weekendTextStyle: TextStyle(
            // 土日の色変更
            color: Colors.red,
          ),
          selectedDateTime: _currentDate, // 初期値として選択する日にち(今日を指定)
          locale: 'JA', // 日本のカレンダーに設定
          daysHaveCircularBorder: true, // 枠線を丸く設定
          customGridViewPhysics:
              NeverScrollableScrollPhysics(), // カレンダーの縦スクロールを固定
        ),
      ),
    );
  }
}

/* 設定画面 */
class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
      ),
    );
  }
}

/* インフォメーション画面 */
class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

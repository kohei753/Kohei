import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:flutter_calendar_carousel/classes/event.dart'; // イベントクラスに関するやーつ
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel; // 献立表のカレンダーに関するAPI

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';

/* 献立表画面 */
class MonthlyMenu extends StatefulWidget {
  final Map<DateTime, Menu> menus;
  final Child child;
  MonthlyMenu({Key key, this.menus, this.child}) : super(key: key);

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
        child: CalendarCarousel<Event>( // カレンダー部分
          onDayPressed: onDayPressed, // 日にちが選択された時の処理
          showOnlyCurrentMonthDate: true, // 一ヶ月のみ表示
          showHeader: false,  // ヘッダー(xx年yy月)を隠す
          weekendTextStyle: TextStyle(
            // 土日の色変更
            color: Colors.red,
          ),

          /* 今日の処理をなくす */
          todayBorderColor: null,
          todayButtonColor: null,
          todayTextStyle: TextStyle(
            color: Colors.black,
          ),

          /* 選択した日の処理 */
          selectedDayBorderColor: Color.fromARGB(0, 0, 0, 255), // 無色(nullだとエラー出る)
          selectedDayButtonColor: Theme.of(context).primaryColor,

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
import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:flutter_calendar_carousel/classes/event.dart'; // イベントクラスに関するやーつ
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel; // 献立表のカレンダーに関するAPI

import 'menu.dart' as menus;
import 'child.dart' as child;

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
        margin: EdgeInsets.symmetric(horizontal: 16.0),
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:intl/intl.dart';
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
  static DateTime testDate1 = DateTime(2019, 8, 19);
  static DateTime testDate2 = testDate1.add(Duration(days: 1));
  static DateTime pickDate = testDate1;
  static String formattedDate = DateFormat('M月d日').format(
      testDate1); //日付をフォーマット

  static bool checkHolidays = false; //Todo　取得した日付でtrue/falseを決める。

  Map<DateTime, Menu> _menus; //引き継いでる変数から持ってきた

  /*読み込まれた時に遷移されてきた変数を代入*/
  @override
  void initState() {
    super.initState();
    _menus = widget.menus;
  }

  /* カレンダーの更新用 */
  void onDayPressed(DateTime date, List<Event> events) {
    String selectedDate = DateFormat('M月d日').format(date);
    setState(() {
      formattedDate = selectedDate;

      if (_menus[date].menu != null) {
        pickDate = date;
      } else {
        checkHolidays = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _calenderScreen(context),
            _lunchScreen(),
          ],
        ),
      ),
    );
  }

  Widget _calenderScreen(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: onDayPressed,
        showOnlyCurrentMonthDate: true,
        showHeader: false,
        weekFormat: false,
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        height: (size.height * 2 / 5) + size.height / 80,
        todayBorderColor: null,
        todayButtonColor: null,
        todayTextStyle: TextStyle(
          color: Colors.black,
        ),
        selectedDayBorderColor: Color.fromARGB(0, 0, 0, 255),
        selectedDayButtonColor: Theme
            .of(context)
            .primaryColor,
        selectedDateTime: pickDate,
        locale: 'JA',
        daysHaveCircularBorder: true,
        customGridViewPhysics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget _lunchScreen() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 300.0,
            height: 50.0,
            child: RaisedButton(
              child: Text(
                '$formattedDate' + 'の献立',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              color: Colors.deepOrangeAccent,
              shape: StadiumBorder(),
              elevation: 8.0,
              onPressed: () {
                Navigator.pushNamed(context, 'dailyMenu');
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: ListView.builder(
              itemCount: _menus[pickDate].menu.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Text(
                  _menus[pickDate].menu[i].name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                    //fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
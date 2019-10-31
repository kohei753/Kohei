import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:intl/intl.dart'; //　日付をフォーマットするやつ
import 'package:flutter_calendar_carousel/classes/event.dart'; // イベントクラスに関するやーつ
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' // // 献立表のカレンダーに関するAPI
    show CalendarCarousel; // 献立表のカレンダーに関するAPI

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/data/dri.dart';
import 'package:sample/data/slis.dart';
import 'package:sample/screen/home.dart';

/* 献立表画面 */
class MonthlyMenu extends StatefulWidget {
  final Map<DateTime, Menu> menus;
  final Child child;
  final DRI dri;
  final SLIS slis;
  final DateTime selectedDay;
  MonthlyMenu({Key key, this.menus, this.child, this.dri, this.slis, this.selectedDay}) : super(key: key);

  @override
  _MonthlyMenuState createState() => _MonthlyMenuState(menus, child, dri, slis, selectedDay);
}

class _MonthlyMenuState extends State<MonthlyMenu> {
  DateTime pickDate; // 選択した日を格納する変数
  String formattedDate; //日付をフォーマットしたのを格納する変数

  final Map<DateTime, Menu> _menus; //引き継いでる変数から持ってきた
  final Child _child;
  final DRI _dri;
  final SLIS _slis;
  final DateTime selectedDay;
  _MonthlyMenuState(this._menus, this._child, this._dri, this._slis, this.selectedDay);

  /*読み込まれた時に遷移されてきた変数を代入*/
  @override
  void initState() {
    super.initState();

    pickDate = selectedDay;
    formattedDate = DateFormat('MM月dd日').format(pickDate);
  }

  /* カレンダーの更新用 */
  void onDayPressed(DateTime date, List<Event> events) {
    String selectedDate = DateFormat('MM月dd日').format(date); // 日付をX月X日にフォーマットし文字列にする
    pickDate = date;
    setState(() {
      formattedDate = selectedDate; // 選択した日付にする
    });
  }


  /* ホームへの遷移 */
  void handleToHome(DateTime selectDay) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/home'),
          builder: (BuildContext context) => Home(
              menus: _menus, child: _child, dri: _dri, slis: _slis, selectDay: selectDay),
        ));
  }

  /* カレンダーのWidget */
  Widget _calenderScreen(Size size) {
    return Container(
      margin: EdgeInsets.all(size.height/200),
      child: CalendarCarousel<Event>(
        onDayPressed: onDayPressed, //日付を押した時の処理
        showOnlyCurrentMonthDate: true, // 今月だけ表示
        showHeader: false, // ヘッダーの表示
        weekendTextStyle: TextStyle(
          //土日の表示スタイル
          color: Colors.red,
        ),

        height: (size.height *  1 / 2), // カレンダーの高さの設定
        childAspectRatio: 1.15,


        todayBorderColor: null, //　今日の日付枠の色
        todayButtonColor: null, //　今日の日付の色
        todayTextStyle: TextStyle(
          // 今日の日付の文字色
            color: Colors.black),

        selectedDayBorderColor: Color.fromARGB(0, 0, 0, 255), //　選択した日の枠の色を設定
        selectedDayButtonColor: Theme.of(context).primaryColor, // 選択した日の色の設定
        selectedDayTextStyle: TextStyle(
          // 選択した日の文字色
            color: Colors.white
        ),
        selectedDateTime: pickDate, //開始する日付
        locale: 'JA', // 言語
        daysHaveCircularBorder: true, //　日付の形を丸にする
        customGridViewPhysics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  /* 「X月X日の献立」を表示する */
  Widget _menuTitle(Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: size.height/50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: size.width * 3 / 5,
            height: size.height / 18,
            child: RaisedButton(
              // ボタン
                child: Text(
                  formattedDate + 'の献立', //　選択した日を出力
                  style: TextStyle(
                    // 文字設定
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                color: Colors.deepOrangeAccent, //　ボタンの色
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Color(0xFFffb499),
                    width: 2.0,
                  ),
                ),
                onPressed: () {
                  if (_menus[pickDate] != null) {
                    handleToHome(DateTime(pickDate.year, pickDate.month, pickDate.day));
                  }
                }),
          ),
        ],
      ),
    );
  }

  /* 献立をリスト表示する */
  Widget _menuList(size) {
    if (_menus[pickDate] == null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: size.height/15),
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.black45,
              ),
              children: [
                TextSpan(text: formattedDate + 'の給食は'),
                TextSpan(text: 'お休み',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Theme.of(context).primaryColor,
                    decorationStyle: TextDecorationStyle.dashed,
                  ),
                ),
                TextSpan(text: 'です.'),
              ],
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Wrap(
              spacing: 10.0,
              runSpacing: 5.0,
              children: List.generate(_menus[pickDate].menu.length, (int index) {
                return Chip(
                  backgroundColor: Color(0xFFffead6),
                  label: Text(
                    _menus[pickDate].menu[index].name,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                  ), // 今日のメニューを表示する
                );
              }),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // 端末の画面を取得
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _calenderScreen(size), // カレンダーのWidget
            _menuTitle(size), // 「X月X日の献立」を表示するWidget
            _menuList(size), // 献立をリスト表示するWidget
          ],
        ),
      ),
    );
  }
}
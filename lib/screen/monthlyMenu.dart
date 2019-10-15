import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:intl/intl.dart'; //　日付をフォーマットするやつ
import 'package:flutter_calendar_carousel/classes/event.dart'; // イベントクラスに関するやーつ
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel; // 献立表のカレンダーに関するAPI

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/data/dri.dart';
import 'package:sample/screen/home.dart';

/* 献立表画面 */
class MonthlyMenu extends StatefulWidget {
  final Map<DateTime, Menu> menus;
  final Child child;
  final DRI dri;
  MonthlyMenu({Key key, this.menus, this.child, this.dri}) : super(key: key);

  @override
  _MonthlyMenuState createState() => _MonthlyMenuState();
}

class _MonthlyMenuState extends State<MonthlyMenu> {
  static DateTime today = DateTime.now(); // 今日の日付
  static DateTime pickDate = today; // 選択した日を格納する変数
  static String formattedDate = DateFormat('M月d日').format(today); //日付をフォーマットしたのを格納する変数

  Map<DateTime, Menu> _menus; //引き継いでる変数から持ってきた
  Child _child;
  DRI _dri;

  /*読み込まれた時に遷移されてきた変数を代入*/
  @override
  void initState() {
    super.initState();
    _menus = widget.menus;
    _child = widget.child;
    _dri = widget.dri;
  }

  /* カレンダーの更新用 */
  void onDayPressed(DateTime date, List<Event> events) {
    String selectedDate = DateFormat('M月d日').format(date);// 日付をX月X日にフォーマットし文字列にする
    pickDate = date;
    setState(() {
      formattedDate = selectedDate;// 選択した日付にする
    });
  }
  /* ListViewのitemCountを決める関数 */
  int checkLunch(DateTime day) {
    int result = 1;
    if(_menus[day] == null){
      return result;
    }
    return _menus[day].menu.length;
  }

  /* ホームへの遷移 */
  void handleToHome(DateTime selectDay) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/home'),
          builder: (BuildContext context) => Home(menus: _menus, child: _child, dri: _dri, selectDay: selectDay),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _calenderScreen(context),// カレンダーのWidget
            _lunchScreen(),// 下の献立の表示のWidget
          ],
        ),
      ),
    );
  }

  /* カレンダーのWidget */
  Widget _calenderScreen(BuildContext context) {
    final Size size = MediaQuery.of(context).size;// 端末の画面を取得
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: onDayPressed,//日付を押した時の処理
        showOnlyCurrentMonthDate: true,// 今月だけ表示
        showHeader: false,// ヘッダーの表示
        weekendTextStyle: TextStyle(//土日の表示スタイル
          color: Colors.red,
        ),

        height: (size.height * 2 / 5) + size.height / 80,// カレンダーの高さの設定

        todayBorderColor: null,//　今日の日付枠の色
        todayButtonColor: null,//　今日の日付の色
        todayTextStyle: TextStyle(// 今日の日付の文字設定
          color: Colors.black,
        ),

        selectedDayBorderColor: Color.fromARGB(0, 0, 0, 255),//　選択した日の枠の色を設定
        selectedDayButtonColor: Theme.of(context).primaryColor,// 選択した日の色の設定
        selectedDateTime: pickDate, //開始する日付
        locale: 'JA',// 言語
        daysHaveCircularBorder: true, //　日付の形を丸にする
        customGridViewPhysics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  /* 献立表示のWidget */
  Widget _lunchScreen() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(// X月X日と表示するためのbox
            width: 300.0,
            height: 50.0,
            child: RaisedButton(// ボタン
              child: Text(
                formattedDate + 'の献立',//　選択した日を出力
                style: TextStyle(// 文字設定
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              color: Colors.deepOrangeAccent,//　ボタンの色
              shape: StadiumBorder(),// 角を丸くする
              elevation: 8.0,// 影をつける
                onPressed: () {
                  if (_menus[pickDate] != null) {
                    handleToHome(DateTime(pickDate.year, pickDate.month, pickDate.day));
                  }
                }
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: ListView.builder(// 献立をリストと表示する
              itemCount: checkLunch(pickDate),// リストの長さ
              shrinkWrap: true,
              itemBuilder: (context, i) {
                if( _menus[pickDate] == null){// タップした日の献立がない時
                  return RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black45,
                          ),
                          children: [
                            TextSpan(text: '本日の給食は'),
                            TextSpan(
                              text: 'お休み',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).primaryColor,
                                decorationStyle: TextDecorationStyle.dashed,
                              ),
                            ),
                            TextSpan(text: 'です.'),
                          ],
                        ),
                      );
                } else { // タップした日の献立がある時
                  return Text(
                    _menus[pickDate].menu[i].name,//献立を表示
                    textAlign: TextAlign.center,
                    style: TextStyle(// 文字の設定
                      fontSize: 18.0,
                      color: Colors.black87,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
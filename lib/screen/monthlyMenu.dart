import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart'; //　日付をフォーマットするやつ

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/data/dri.dart';
import 'package:sample/data/slis.dart';
import 'package:sample/screen/home.dart';
import 'package:sample/data/strings.dart';

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
  DateTime today;
  List<String> formattedDate; //日付をフォーマットしたのを格納する変数
  List<DateTime> dateArray;
  List<Color> _mainDetailColors = MenuStrings.mainDetailColors;
  Map<DateTime, Menu> allMenu;

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
    pickDate = DateTime(2019, 8, 19);
    dateUpdate(pickDate);

  }

  void dateUpdate(DateTime date) {
    int count = 0;
    today = date;
    formattedDate = [];
    dateArray = [];
    for (var i = 1 - date.weekday; i < 8 - date.weekday; i++) {
      dateArray.add(DateTime(date.year, date.month, date.day + i));
      formattedDate.add(DateFormat('M/d').format(dateArray[count]));
      count++;
    }
  }





  //TODO: 週を遷移させるのがきつい...

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

  Widget _changeWeek(size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black87,
              size: 48.0,
            ),
            onPressed: (){
                setState(() {
                  dateUpdate(DateTime(today.year, today.month, today.day - 7));
                });
            },
          ),
          Text(
            formattedDate[0] + '〜' + formattedDate[4] +'の献立',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black87,
              size: 48.0,
            ),
            onPressed: (){
                setState(() {
                  dateUpdate(DateTime(today.year, today.month, today.day + 7));
                });
            },
          ),
        ],
      ),
    );
  }

  /* 献立をリスト表示する */
  Widget _menuList(size) {
    return SizedBox(
        width: size.width * 19/20,
        height: size.height * 13/20,
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index1){
              if(_menus[dateArray[index1]] == null) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: size.height/10),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black45,
                          ),
                          children: [
                            TextSpan(text: formattedDate[index1] + 'の給食は'),
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
                  ),
                );
              } else {
                return Card(
                  child:Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      onTap: (){
                        handleToHome(dateArray[index1]);
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            formattedDate[index1],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Container(
                              width: 1,
                              height: 85,
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: Wrap(
                              spacing: 10.0,
                              runSpacing: 5.0,
                              children: List.generate(_menus[dateArray[index1]].menu.length, (int index) {
                                return Text(
                                  _menus[dateArray[index1]].menu[index].name,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 3.0,
                                    decorationColor: _mainDetailColors[index],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // 端末の画面を取得
    return Scaffold(
      backgroundColor: Color(0xFFffead6),
      body: Column(
        children: <Widget>[
          _changeWeek(size),
          _menuList(size),
        ],
      ),
    );
  }
}
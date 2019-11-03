import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart'; //　日付をフォーマットするやつ

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
  List<String> formattedDate = []; //日付をフォーマットしたのを格納する変数
  List<DateTime> dateArray = [];

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

    //pickDate = selectedDay;
    pickDate = DateTime(2019, 8, 19);

    int count = 0;
    for (var i = 1 - pickDate.weekday; i < 6 - pickDate.weekday; i++) {
      dateArray.add(DateTime(pickDate.year, pickDate.month, pickDate.day + i));
      formattedDate.add(DateFormat('MM月dd日').format(dateArray[count]));
      count++;
    }
  }

  //TODO: dateを受け取った際に配列に格納して曜日を管理する

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
          Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black87,
            size: 48.0,
          ),
          Text(
            formattedDate[0] + '〜' + formattedDate[4] +'の献立',
          ),
          Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black87,
              size: 48.0,
          ),
        ],
      ),
    );
  }

  /* 献立をリスト表示する */
  Widget _menuList(size) {
    return SizedBox(
        width: size.width,
        height: size.height,
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index1){
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
                            height: 100,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _menus[dateArray[index1]].menu.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index){
                              return Text(
                                _menus[dateArray[index1]].menu[index].name,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // 端末の画面を取得
    return Scaffold(
      body: Column(
        children: <Widget>[
          _changeWeek(size),
          _menuList(size),
        ],
      ),
    );
  }
}
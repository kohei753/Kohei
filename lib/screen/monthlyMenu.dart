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
  Widget build(BuildContext context) {//画面の設定
    return Scaffold(
        appBar: new AppBar(
          title: new Text('カレンダー画面'),
        ),
        body: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _calenderScreen(context),
              _schoollunchScreen(),
            ],
          ),
        )
    );
  }

  Widget _calenderScreen(BuildContext context) {//カレンダーの画面
    final Size size = MediaQuery.of(context).size;//画面のサイズを取得する
    return Container(
      child: CalendarCarousel<Event>( // カレンダー部分
            onDayPressed: onDayPressed, // 日にちが選択された時の処理
            showOnlyCurrentMonthDate: true, // 一ヶ月のみ表示
            showHeader: false,  // ヘッダー(xx年yy月)を隠す
            weekendTextStyle: TextStyle(
              // 土日の色変更
              color: Colors.red,
            ),

            //カレンダーの高さ
            height: size.height * 1/2,

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
        );
  }

  Widget _schoollunchScreen(){//下の献立表を出力する画面
    // List<String> listDish = [];//メニューを格納するリスト
//    for (var i = 0; i < todayDish.length; i++) {//todayDishから順番に料理名を取り出しlistDishに格納している
//      listDish.add(todayDish[i].dishName);
//    }
//    if(listDish.length < 6){//最大6品なので5品目しかない時に6個目を追加!ここのところをもう少しスマートに描きたい...
//      listDish.add("");
//    }
    return Container(
        margin: EdgeInsets.all(16.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(//○月○日の献立と表示させるためのboxの設定
              width: 500.0,
              height: 50.0,
              child:  RaisedButton(//ボタン
                onPressed: () {
                  Navigator.pushNamed(context, '/details');
                },
                child:  Text(
                  'その日の献立',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:16.0,
                  ),
                ),
              ),
            ),
            Container(//主食のメニュー
              margin: EdgeInsets.only(left:50.0,top:20.0),
              child: Row(
                  children:<Widget>[
                    Text(
                      '主食   ',//ここら辺を変える必要がある
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:20.0,
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'ご飯',//ここら辺をmenuとかに置き換える？
                            style: TextStyle(
                              fontSize:16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
              ),
            ),
            Container(//副食のメニュー・もう少し中をスマートに描きたい...
              margin: EdgeInsets.only(left:50.0),
              child: Row(
                  children:<Widget>[
                    Text(
                      '副食   ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:20.0,
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'おかず1',//ここら辺をmenuとかに置き換える？
                            style: TextStyle(
                              fontSize:16.0,
                            ),
                          ),
                          Text(
                            'おかず2',//ここら辺をmenuとかに置き換える？
                            style: TextStyle(
                              fontSize:16.0,
                            ),
                          ),
                          Text(
                            'おかず3',//ここら辺をmenuとかに置き換える？
                            style: TextStyle(
                              fontSize:16.0,
                            ),
                          ),
                          Text(
                            'おかず4',//ここら辺をmenuとかに置き換える？
                            style: TextStyle(
                              fontSize:16.0,
                            ),
                          ),
                          Text(
                            'おかず5',//ここら辺をmenuとかに置き換える？
                            style: TextStyle(
                              fontSize:16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
              ),
            ),
          ],
        )
    );
  }

}
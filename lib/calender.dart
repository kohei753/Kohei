
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

import 'quanity.dart';
import 'foodStuff.dart';
import 'dish.dart';
import 'menu.dart';

class calenderState extends State<calender> {
  static DateTime _currentDate = DateTime.now();
  static DateTime _tomorrow  = _currentDate.add(Duration(days :1));
  static String formattedDate = DateFormat('M月d日').format(_currentDate);//日付をフォーマット




  static Quantity quanity1 = new Quantity(null,100.0);


  static FoodStuff foodStuff1 = new FoodStuff(
      "小麦粉",
      false,
      false,
      quanity1,
      false,
      776.0,
      10.0,
      10.0,
      10.0,
      10.0,
      10.0,
      10.0,
      10.0,
      10.0,
      10.0,
      10.0,
      10.0,
      10.0,
      10.0,
      10.0
  );

  static List<FoodStuff> dish = [foodStuff1];

  static Dish dish1 = new Dish(dish, "小型コッパパン","主食");
  static Dish dish2 = new Dish(dish, "きつねうどん","副食");
  static Dish dish3 = new Dish(dish, "うの花コロッケ","副食");
  static Dish dish4 = new Dish(dish, "すいか","副食");
  static Dish dish5 = new Dish(dish, "チョコクリーム","副食");
  static Dish dish6 = new Dish(dish, "牛乳","副食");

  static Dish dish7 = new Dish(dish, "ごはん","主食");
  static Dish dish8 = new Dish(dish, "カレー豆腐","副食");
  static Dish dish9 = new Dish(dish, "きびなごフライ","副食");
  static Dish dish10 = new Dish(dish, "トマト","副食");
  static Dish dish11 = new Dish(dish, "牛乳","副食");

  static String schoolName = "巴中学校";
  static List<Dish> dishList1 = [dish1,dish2,dish3,dish4,dish5,dish6];
  static List<Dish> dishList2 = [dish7,dish8,dish9,dish10,dish11];

  static Menu menu1 = new Menu(_currentDate, schoolName, dishList1);//今日のメニュー
  static Menu menu2 = new Menu(_tomorrow, schoolName, dishList2);//明日のメニュー

  static List<Menu> menuList = [menu1,menu2];//メニューのリスト

  static List<Dish> todayDish = List.from(menuList[0].listMenu);//今日の料理リストを格納する変数



  void onDayPressed(DateTime date, List<Event> events) {//選択した日付を扱う日付にする関数
    String Date = DateFormat('M月d日').format(date);
    for(var i = 0; i < menuList.length; i++){//for文で選択した日付と合う献立を探す
      String compareDate = DateFormat('M月d日').format(menuList[i].menuDate);
      if(compareDate == Date){//日付が合う献立があれば...
        if(todayDish.length == 0){//todayDishに要素がなければ代入、あれば置き換える
          todayDish = List.from(menuList[i].listMenu);
        }else{
          todayDish.removeAt(0);
          todayDish = List.from(menuList[i].listMenu);
        }
      }
    }
    setState(() {
      formattedDate = Date;
    });
  }

  Widget _calenderScreen(BuildContext context) {//カレンダーの画面
    final Size size = MediaQuery.of(context).size;//画面のサイズを取得する
    return Container(
      child: CalendarCarousel<Event>(
        locale:'ja_JP',
        showOnlyCurrentMonthDate:true,
        onDayPressed: onDayPressed,
        weekendTextStyle: TextStyle(color: Colors.red),
        weekFormat: false,
        height: size.height * 1/2,
        selectedDateTime: _currentDate,
        todayTextStyle: TextStyle(
          color: Colors.white,
        ),
        todayBorderColor: Colors.green,
      ),
    );
  }

  Widget _schoollunchScreen(){//下の献立表を出力する画面
    List<String> listDish = [];//メニューを格納するリスト
    for (var i = 0; i < todayDish.length; i++) {//todayDishから順番に料理名を取り出しlistDishに格納している
      listDish.add(todayDish[i].dishName);
    }
    if(listDish.length < 6){//最大6品なので5品目しかない時に6個目を追加!ここのところをもう少しスマートに描きたい...
      listDish.add("");
    }
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
                  '$formattedDateの献立',
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
                            listDish[0],//ここら辺をmenuとかに置き換える？
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
                            listDish[1],//ここら辺をmenuとかに置き換える？
                            style: TextStyle(
                              fontSize:16.0,
                            ),
                          ),
                          Text(
                            listDish[2],//ここら辺をmenuとかに置き換える？
                            style: TextStyle(
                              fontSize:16.0,
                            ),
                          ),
                          Text(
                            listDish[3],//ここら辺をmenuとかに置き換える？
                            style: TextStyle(
                              fontSize:16.0,
                            ),
                          ),
                          Text(
                            listDish[4],//ここら辺をmenuとかに置き換える？
                            style: TextStyle(
                              fontSize:16.0,
                            ),
                          ),
                          Text(
                            listDish[5],//ここら辺をmenuとかに置き換える？
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
}

class detailsState extends State<details> {//選択した日付の献立画面へ行った先のクラス（仮）
  String currentDate = calenderState.formattedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$currentDateの献立画面')),
      body: Center(
        child: RaisedButton(
          child: Text('カレンダー画面に戻る'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}


class calender extends StatefulWidget {
  @override
  calenderState createState() => calenderState();
}

class details extends StatefulWidget {
  @override
  detailsState createState() => detailsState();
}
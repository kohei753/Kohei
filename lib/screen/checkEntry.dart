import 'package:flutter/material.dart';

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/data/dri.dart';

class CheckEntry extends StatefulWidget {
  final Map<DateTime, Menu> menus;
  final DRI dri;
  final Child child;
  CheckEntry({Key key, this.menus, this.dri, this.child}) : super(key: key);

  @override
  _CheckEntryState createState() => _CheckEntryState();
}

class _CheckEntryState extends State<CheckEntry> {
  //引き継いだ情報の読み込み
  Map<DateTime, Menu> menus;
  DRI dri;
  Child child;

  /* この画面でのみ使用する変数 */
  String sexLabel;
  String yearLabel;

  @override
  void initState() {
    //空の変数に引き継いだ情報を渡す
    super.initState();
    menus = widget.menus;
    dri = widget.dri;
    child = widget.child;

    sexLabel = (child.sex == 0) ? '男' : '女';
//    if (child.sex == 0) {
//      sexLabel = '男';
//    } else {
//      sexLabel = '女';
//    }
    if (child.schoolYear < 7) {
      yearLabel = '${child.schoolYear}年生';
    } else {
      yearLabel = '${child.schoolYear - 6}年生';
    }
  }
  //todo　確認画面から変更するための遷移
  Widget _summon(String item, String element){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              item,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Text(
            element,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
        trailing: Text(
          '変更',
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).accentColor,
          ),
        ),
        onTap:(){},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('確認画面'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox( //  appbarと本文の隙間
            height: 40.0,
            width: 30.0,
          ),
          _summon('名前',child.name),
          _summon('性別',sexLabel),
          _summon('学校',child.school),
          _summon('学年',yearLabel),
          SizedBox(height: 20), // 縦の間の余白の大きさ
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // 右端行くやつ
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: ButtonTheme(
                  // ボタンの大きさ
                  minWidth: 100, //必要最小限度の幅
                  height: 40, //長さ
                  child: RaisedButton(
                    //ボタンについての設定
                    onPressed:(){}, //押した時のエフェクト
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white, //ボタンの文字
                    shape: StadiumBorder(),
                    child: Text('確定'), //ボタン内の文字
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


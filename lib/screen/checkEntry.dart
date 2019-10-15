import 'package:flutter/material.dart';

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/data/dri.dart';
import 'home.dart';

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
  String _sexLabel; // 性別: int => String
  String _yearLabel; // 学年: int => String

  @override
  void initState() {
    //空の変数に引き継いだ情報を渡す
    super.initState();
    menus = widget.menus;
    dri = widget.dri;
    child = widget.child;

    _sexLabel = (child.sex == 0) ? '男' : '女';
    if (child.schoolYear < 7) {
      _yearLabel = '${child.schoolYear}年生';
    } else {
      _yearLabel = '${child.schoolYear - 6}年生';
    }
  }

  /* 登録処理 */
  void entryChild() {
    writeInfo(child); // 情報の登録
    handleToHome();
  }

  /* 名前変更へ遷移 */
  void handleToName() {

  }

  /* 性別変更へ遷移 */
  void handleToSex() {

  }

  /* 学校変更へ遷移 */
  void handleToSchool() {

  }

  /* 学年変更へ遷移 */
  void handleToYear() {

  }

  /* ホーム画面への遷移 */
  void handleToHome() {
    DateTime today = DateTime.now();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/home'),
          builder: (BuildContext context) => Home(menus: menus, child: child, dri: dri, selectDay: DateTime(today.year, today.month, today.day)),
        ));
  }

  /* Body */
  Widget _buildBody() {
    return Column(
      children: <Widget>[
        SizedBox(
          //  appbarと本文の隙間
          height: 40.0,
          width: 30.0,
        ),
        _entryLabel('名前', child.name),
        _entryLabel('性別', _sexLabel),
        _entryLabel('学校', child.school),
        _entryLabel('学年', _yearLabel),
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
                  onPressed: entryChild, //押した時のエフェクト
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
    );
  }

  /* １つの項目 */
  Widget _entryLabel(String item, String element) {
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
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('確認'),
      ),
      body: _buildBody(),
    );
  }
}

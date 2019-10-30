import 'package:flutter/material.dart';

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/data/dri.dart';
import 'package:sample/screen/changeEntry.dart';
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

  /* 最終的に登録する値 */
  String name;
  int sex;
  String school;
  int schoolYear;

  @override
  void initState() {
    //空の変数に引き継いだ情報を渡す
    super.initState();
    menus = widget.menus;
    dri = widget.dri;
    child = widget.child;

    name = child.name;
    sex = child.sex;
    school = child.school;
    schoolYear = child.schoolYear;
    _sexLabel = (sex == 0) ? '男' : '女';
    if (schoolYear < 7) {
      _yearLabel = '${child.schoolYear}年生';
    } else {
      _yearLabel = '${child.schoolYear - 6}年生';
    }
  }

  /* 登録処理 */
  void entryChild() {
    // 情報の登録
    writeInfo(Child(name, school, schoolYear, sex)).then((value) {
      handleToHome();
    });
  }

  /* 各画面への遷移を管理 */
  void handleToNext(int selectItem) {
    switch (selectItem) {
      case 0:
        handleToName();
        break;
      case 1:
        handleToSex();
        break;
      case 2:
        handleToSchool();
        break;
      case 3:
        handleToYear();
        break;
      default:
        break;
    }
  }

  /* 名前変更へ遷移 */
  void handleToName() async {
    Child newChild = await Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: '/changeName'),
        builder: (BuildContext context) =>
            ChangeName(child: Child(name, school, schoolYear, sex)),
      ),
    );
    if ((newChild != null) && (name != newChild.name)) {
      setState(() {
        name = newChild.name;
      });
    }
  }

  /* 性別変更へ遷移 */
  void handleToSex() async {
    Child newChild = await Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: '/changeSex'),
        builder: (BuildContext context) =>
            ChangeSex(child: Child(name, school, schoolYear, sex)),
      ),
    );
    if ((newChild != null) && (sex != newChild.sex)) {
      setState(() {
        sex = newChild.sex;
        _sexLabel = (sex == 0) ? '男子' : '女子';
      });
    }
  }

  /* 学校変更へ遷移 */
  void handleToSchool() async {
    Child newChild = await Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: '/changeSchool'),
        builder: (BuildContext context) =>
            ChangeSchool(child: Child(name, school, schoolYear, sex)),
      ),
    );
    if ((newChild != null) && (school != newChild.school)) {
      setState(() {
        school = newChild.school;
      });
    }
  }

  /* 学年変更へ遷移 */
  void handleToYear() async {
    Child newChild = await Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: '/changeSchoolYear'),
        builder: (BuildContext context) =>
            ChangeYear(child: Child(name, school, schoolYear, sex)),
      ),
    );
    if ((newChild != null) && (schoolYear != newChild.schoolYear)) {
      setState(() {
        schoolYear = newChild.schoolYear;
        if (schoolYear < 7) {
          _yearLabel = '$schoolYear年生';
        } else {
          _yearLabel = '${schoolYear - 6}年生';
        }
      });
    }
  }

  /* ホーム画面への遷移 */
  void handleToHome() {
    DateTime today = DateTime.now();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/home'),
          builder: (BuildContext context) => Home(
              menus: menus,
              child: Child(name, school, schoolYear, sex),
              dri: dri,
              selectDay: DateTime(today.year, today.month, today.day)),
        ));
  }

  /* Body */
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            //  appbarと本文の隙間
            height: 40.0,
            width: 30.0,
          ),
          _entryLabel('名前', name, 0),
          _entryLabel('性別', _sexLabel, 1),
          _entryLabel('学校', school, 2),
          _entryLabel('学年', _yearLabel, 3),
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
                    child: Text('登録'), //ボタン内の文字
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /* １つの項目 */
  Widget _entryLabel(String item, String element, int selectItem) {
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
        onTap: () => handleToNext(selectItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('確認'),
      ),
      body: _buildBody(),
    );
  }
}

import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/child.dart';
import 'package:sample/screen/changeEntry.dart';

/* インフォメーション画面 */
class Account extends StatefulWidget {
  final Child child;
  Account({Key key, this.child}) : super(key: key);

  @override
  _AccountState createState() => _AccountState(child);
}

class _AccountState extends State<Account> {
  /* 変数の引き継ぎ */
  final Child child;
  _AccountState(this.child);

  /* この画面でのみ使用する変数 */
  String _sexLabel; // 性別: int => String
  String _yearLabel; // 学年: int => String
  String name;
  int sex;
  String school;
  int schoolYear;

  @override
  void initState() {
    //空の変数に引き継いだ情報を渡す
    super.initState();

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
      await writeInfo(Child(name, school, schoolYear, sex));
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
      await writeInfo(Child(name, school, schoolYear, sex));
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
      await writeInfo(Child(name, school, schoolYear, sex));
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
      await writeInfo(Child(name, school, schoolYear, sex));
    }
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('登録情報'),
      ),
      body: _buildBody(),
    );
  }
}

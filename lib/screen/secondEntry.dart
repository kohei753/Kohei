import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart' as child;
import 'package:sample/data/dri.dart';
import 'home.dart';

/* 初期登録画面 */
class SecondEntry extends StatefulWidget {
  final Map<DateTime, Menu> menus;
  final DRI dri;
  final String name;
  final int sex;
  SecondEntry({Key key, this.menus, this.dri, this.name, this.sex})
      : super(key: key);

  @override
  _SecondEntryState createState() => _SecondEntryState();
}

class _SecondEntryState extends State<SecondEntry> {
  Map<DateTime, Menu> menus = {};
  DRI dri;
  String name;
  int sex;

  /* 登録する情報 */
  child.Child myChild;
  String school = '学校を選択';

  /* この中だけで使う変数 */
  List<String> _schoolName = [
    '--- 学校を選択 ---',
    '巴中学校',
    '２個目の選択',
  ];

  void _onTapSchool(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 4,
          child: CupertinoPicker.builder(
            onSelectedItemChanged: _onSelectedItemChanged,
            itemExtent: 40.0,
            childCount: _schoolName.length,
            itemBuilder: (context, index) {
              return Text(_schoolName[index]);
            },
          ),
        );
      },
    );
  }

  void _onSelectedItemChanged(int value) {
    setState(() {
      if (value != 0) school = _schoolName[value];
    });
  }

  /* ホーム画面への遷移 */
  void handleToHome() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/home'),
          builder: (BuildContext context) =>
              Home(menus: menus, child: myChild, dri: dri),
        ));
  }

  /* Body */
  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          _buildSchoolSelect(),
        ],
      ),
    );
  }

  /* 学校選択のWidget */
  Widget _buildSchoolSelect() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(30.0, 0.0, 40.0, 0.0),
        title: Text(
          '学校',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        trailing: Text(
          school,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black38,
          ),
        ),
        onTap: () => _onTapSchool(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('登録'),
      ),
      body: _buildBody(),
    );
  }
}

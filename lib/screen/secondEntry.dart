import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';   //  マテリアルデザインしようぜのやーつ

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
  child.Child myChild;  // childと言う名前でimportしてきたChild型のmyChildというクラスを宣言
  String school = '学校を選択';  // デフォルトの選択内容を'学校を選択'にしている
  int schoolYear = 0; // 内部の登録学年(内部では1-9で設定)
  
  /* この中だけで使う変数 */
  String schoolYearLabel = '学年を選択';
  List<String> _schoolName = [  // _schoolNameという配列を作成
    '--- 学校を選択 ---',  // 0番目
    '巴中学校',  // 1番目
    '２個目の選択',  // 2番目　
  ];

  List<String> _schoolYearList = [  //  表面上の学年
    '--- 学年を選択 ---',
    '1年',
    '2年',
    '3年',
  ];

  void _onTapSchool(BuildContext context) {  // 返り値なし関数__onTapSchoolを宣言
    showModalBottomSheet(  // このメソッドによって下から選択するためのシートを作成
      context: context,  // 画面を変更させるためにこの画面自身を引数に
      builder: (BuildContext context) {  // リストの中身の作成
        return Container(  // heightを設定するためにラッピング
          height: MediaQuery.of(context).size.height / 4,  // 後に呼び出すシートの縦幅を端末の4分の1の大きさに指定
          child: CupertinoPicker.builder(  // メインの関数、この関数でホイールを作成する
            onSelectedItemChanged: _onSelectedItemChanged,  // ホイールを動かした時のコールバック(選択先の番号がintで引数)
            itemExtent: 40.0,  // ホイールで使用する文字の大きさ(項目の大きさ)
            childCount: _schoolName.length,  // ホイールで使用する項目の上限
            itemBuilder: (context, index) {  // ホイールで使用する項目そのもの
              return Text(_schoolName[index]);  // 1アイテムの生成
            },
          ),
        );
      },
    );
  }

  void _onTapSchoolYear(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height / 4,
            child: CupertinoPicker.builder(
                onSelectedItemChanged: _onSelectedItemChanger,
                itemExtent: 40.0,
                childCount: _schoolYearList.length,
                itemBuilder: (context, index) {
                  return Text(_schoolYearList[index]);
                },
            ),
          );
          },
    );
  }

  void _onSelectedItemChanged(int value) {  // ホイールで使用する対象に関する関数
    setState(() {  // ホイールを回して項目を変える度に更新(更新を反映させるためにこの関数が必要)
      if (value != 0)   // 0番目(デフォルトの'学校を選択')でなければ
        school = _schoolName[value];  // 選択中の学校名を設定
    });  // ifが存在しているのは'学校を選択'を一度ホイールを回せば設定できなくさせるため
  }

  void _onSelectedItemChanger(int value) {  // ホイールで使用する対象に関する関数
    setState(() {  // ホイールを回して項目を変える度に更新(更新を反映させるためにこの関数が必要)
      if (value != 0)   // 0番目(デフォルトの'学校を選択')でなければ
        schoolYearLabel = _schoolYearList[value];
        schoolYear = value;  // 選択中の学校名を設定
    });  // ifが存在しているのは'学校を選択'を一度ホイールを回せば設定できなくさせるため
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
          _buildYearSelect(),
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
          school, //  ホイールで設定中の項目を表示
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black38,
          ),
        ),
        onTap: () => _onTapSchool(context),  // '学校'が書かれている行を押せば右の関数が起動
      ),
    );
  }

  Widget _buildYearSelect() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(30.0, 0.0, 40.0, 0.0),
        title: Text(
          '学年',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        trailing: Text(
          schoolYearLabel, //  ホイールで設定中の項目を表示
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black38,
          ),
        ),
        onTap: () => _onTapSchoolYear(context),  // '学校'が書かれている行を押せば右の関数が起動
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
      //  TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('登録'),
      ),
      body: _buildBody(),
    );
  }
}

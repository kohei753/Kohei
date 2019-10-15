import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';   //  マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart' as child;
import 'package:sample/data/dri.dart';
import 'checkEntry.dart';

/* 学校・学年登録画面 */
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
  Map<DateTime, Menu> menus;
  DRI dri;

  /* 登録する情報 */
  String school = '学校を選択';  // デフォルトの選択内容を'学校を選択'にしている
  int schoolYear = 0; // 内部の登録学年(内部では1-9で設定)
  
  /* この中だけで使う変数 */
  String schoolYearLabel = '学年を選択';
  String errorElement = '学校・学年';
  Color errorTextColor = Color.fromARGB(0, 0, 0, 255);
  List<String> _schoolName = [  // _schoolNameという配列を作成
    '--- 学校を選択 ---',  // 0番目
    '巴中学校',  // 1番目
  ];

  List<String> _schoolYearList = [  //  表面上の学年
    '--- 学年を選択 ---',
    '1年',
    '2年',
    '3年',
  ];

  @override
  void initState() {
    super.initState();

    menus = widget.menus;
    dri = widget.dri;
  }

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

  /* Body */
  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.only(top: 30.0,),
      child: Column(
        children: <Widget>[
          _buildSchoolSelect(),
          _buildYearSelect(),
          Row(
            children: <Widget>[
              SizedBox(
                height: 40.0,
                width: 30.0,
              ),
              Text(
                errorElement + 'を選択してください',
                style: TextStyle(
                  fontSize: 12.0,
                  color: errorTextColor,
                ),
              ),
            ],
          ),
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
                    onPressed:  entryInfo, //押した時のエフェクト
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white, //ボタンの文字
                    shape: StadiumBorder(),
                    child: Text('次へ'), //ボタン内の文字
                  ),
                ),
              ),
            ],
          ),
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

  void entryInfo() {
    //  入力情報の確認
    bool schoolCheck = false;
    for (var i = 1; i < _schoolName.length; i++) {
      if (school == _schoolName[i]) schoolCheck = true;
    }
    setState(() {
      if (schoolCheck && schoolYear != 0) {
        errorTextColor = Color.fromARGB(0, 0, 0, 255);
        menus = widget.menus;
        dri = widget.dri;

        child.writeInfo(child.Child(widget.name, school, schoolYear, widget.sex));

        handleToCheck();
      } else if (0 < schoolYear && schoolYear < 10) {
        errorTextColor = Theme.of(context).errorColor;
        errorElement = '学校';
      } else if (schoolCheck) {
        errorTextColor = Theme.of(context).errorColor;
        errorElement = '学年';
      } else {
        errorTextColor = Theme.of(context).errorColor;
        errorElement = '学校・学年';
      }
    });
  }

  void handleToCheck() {  //  確認画面への遷移
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/checkEntry'),
          builder: (BuildContext context) =>
              CheckEntry(menus: menus, dri: dri, child: child.Child(widget.name, school, schoolYear, widget.sex)),
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


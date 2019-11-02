import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart';
import 'package:sample/data/dri.dart';
import 'package:sample/data/slis.dart';
import 'secondEntry.dart';

/* 初期登録画面 */
class FirstEntry extends StatefulWidget {
  final Map<DateTime, Menu> menus;
  final DRI dri;
  final SLIS slis;
  FirstEntry({Key key, this.menus, this.dri, this.slis}) : super(key: key);

  @override
  _FirstEntryState createState() => _FirstEntryState(menus, dri, slis);
}

class _FirstEntryState extends State<FirstEntry> {
  final Map<DateTime, Menu> menus; // JSONから取得したメニュー情報(この画面では使わないが、次の画面に引き渡すために必要)
  final DRI dri;
  final SLIS slis;
  _FirstEntryState(this.menus, this.dri, this.slis);

  /* 登録する情報 */
  String name;
  int gender = 2;

  /* この画面内のみで使う変数 */
  final _formKey = GlobalKey<FormState>(); // 入力フォームを検知するキー
  MaterialAccentColor manButtonColor; // 男のボタンの色
  MaterialAccentColor womanButtonColor; // 女のボタンの色
  Color manTextColor = Colors.black;
  Color womanTextColor = Colors.black;
  Color genderErrorColor = Color.fromARGB(0, 0, 0, 255);

  /* 男女のボタンを押すと選択した方の色がつく
  * gender = 0: man, 1: woman */
  void _genderUpdate(int newGender) {
    setState(() {
      gender = newGender;
      if (gender == 0) {
        manButtonColor = Colors.blueAccent;
        manTextColor = Colors.white;
        womanButtonColor = null;
        womanTextColor = Colors.black;
      } else {
        manButtonColor = null;
        manTextColor = Colors.black;
        womanButtonColor = Colors.redAccent;
        womanTextColor = Colors.white;
      }
    });
  }

  /* 名前の更新 */
  void _nameUpdate(String newName) {
    setState(() {
      name = newName;
    });
  }

  /* 入力情報を登録 */
  void entryInfo() {
    // 入力情報のチェック
    if (_formKey.currentState.validate() && (gender == 0 || gender == 1)) { //何かがフォームに記入されてる(validate)or男女がどちらか選択されていればok
      _formKey.currentState.save();

      handleToSecond();
    } else {
      if (gender > 1) {
        setState(() {
          genderErrorColor = Theme.of(context).errorColor;
        });
      } else {
        setState(() {
          genderErrorColor = Color.fromARGB(0, 0, 0, 255);
        });
      }
    }
  }

  /* ホーム画面への遷移 */
  void handleToSecond() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: '/secondEntry'),
          builder: (BuildContext context) =>
              SecondEntry(menus: menus, dri: dri, slis: slis, name: name, sex: gender),
        ));
  }

  /* Body */
  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 左揃え
          children: <Widget>[
            Text(
              '名前',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(), // 枠線追加
                hintText: 'お子様の名前を入力してください',
              ),
              maxLength: 15,
              validator: (value) {
                // 入力チェック
                if (value.isEmpty) {
                  // 何も入力されていなかったら
                  return '名前を入力してください';
                } else {
                  return null;
                }
              },
              // 入力された文字を取得して、nameを書き換え
              onSaved: (value) {
                // 情報の更新
                _nameUpdate(value);
              },
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 両端に行くやつ
              children: <Widget>[
                Text(
                  '性別',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // くっつくやつ
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => _genderUpdate(0),
                      child: Text(
                        '男子',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: manTextColor,
                        ),
                      ),
                      color: manButtonColor,
                    ),
                    RaisedButton(
                      onPressed: () => _genderUpdate(1),
                      child: Text(
                        '女子',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: womanTextColor,
                        ),
                      ),
                      color: womanButtonColor,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  '性別を選択してください',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: genderErrorColor,
                  ),
                ),
              ],
            ),
            //ここからボタンについて！次へ）
            SizedBox(height: 20), // 縦の間の余白の大きさ
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // 右端行くやつ
              children: <Widget>[
                ButtonTheme(
                  // ボタンの大きさ
                  minWidth: 100, //必要最小限度の幅
                  height: 40, //長さ
                  child: RaisedButton(
                    //ボタンについての設定
                    onPressed: entryInfo, //押した時のエフェクト
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white, //ボタンの文字
                    shape: StadiumBorder(),
                    child: Text('次へ'), //ボタン内の文字
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登録'),
      ),
      body: _buildBody(),
    );
  }
}

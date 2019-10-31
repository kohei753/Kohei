import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:sample/data/child.dart';

/* 名前変更のクラス */
class ChangeName extends StatefulWidget {
  final Child child;
  ChangeName({Key key, this.child}) : super(key: key);

  @override
  _ChangeNameState createState() => _ChangeNameState(child);
}

class _ChangeNameState extends State<ChangeName> {
  /* 引き継いだ情報 */
  final Child child;
  _ChangeNameState(this.child);

  /* この画面でのみ使う変数 */
  final _formKey = GlobalKey<FormState>(); // 入力フォームを検知するキー
  String name;

  @override
  void initState() {
    super.initState();

    name = child.name;
  }

  /* 名前の更新 */
  void _nameUpdate(String value) {
    setState(() {
      name = value;
    });
  }

  /* 情報の登録 */
  void _entryInfo() {
    if (_formKey.currentState.validate()) {
      // 何かがフォームに記入されてる(validate)or男女がどちらか選択されていればok
      _formKey.currentState.save();

      handleToBack();
    }
  }

  /* 遷移元に戻る */
  void handleToBack() {
    Navigator.of(context)
        .pop(Child(name, child.school, child.schoolYear, child.sex));
  }

  /* Body */
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Form(
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
                initialValue: name,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(), // 枠線追加
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
                      onPressed: _entryInfo, //押した時のエフェクト
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white, //ボタンの文字
                      shape: StadiumBorder(),
                      child: Text('更新'), //ボタン内の文字
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('名前変更'),
      ),
      body: _buildBody(),
    );
  }
}

/* 性別変更のクラス */
class ChangeSex extends StatefulWidget {
  final Child child;
  ChangeSex({Key key, this.child}) : super(key: key);

  @override
  _ChangeSexState createState() => _ChangeSexState(child);
}

class _ChangeSexState extends State<ChangeSex> {
  /* 引き継いだ情報 */
  final Child child;
  _ChangeSexState(this.child);

  /* 変更先 */
  int gender;

  /* ボタンまわり */
  MaterialAccentColor manButtonColor; // 男のボタンの色
  MaterialAccentColor womanButtonColor; // 女のボタンの色
  Color manTextColor;
  Color womanTextColor;

  @override
  void initState() {
    super.initState();

    gender = child.sex;
    _genderUpdate(gender);
  }

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

  /* 遷移元に戻る */
  void handleToBack() {
    Navigator.of(context)
        .pop(Child(child.name, child.school, child.schoolYear, gender));
  }

  /* Body */
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                  onPressed: handleToBack, //押した時のエフェクト
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white, //ボタンの文字
                  shape: StadiumBorder(),
                  child: Text('更新'), //ボタン内の文字
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('性別変更'),
      ),
      body: _buildBody(),
    );
  }
}

/* 学校変更のクラス */
class ChangeSchool extends StatefulWidget {
  final Child child;
  ChangeSchool({Key key, this.child}) : super(key: key);

  @override
  _ChangeSchoolState createState() => _ChangeSchoolState(child);
}

class _ChangeSchoolState extends State<ChangeSchool> {
  /* 引き継いだ情報 */
  final Child child;
  _ChangeSchoolState(this.child);

  /* 変更先 */
  String school;

  /* この中だけで使う変数 */
  List<String> _schoolName = [
    // _schoolNameという配列を作成
    '--- 学校を選択 ---', // 0番目
    '巴中学校', // 1番目
  ];

  @override
  void initState() {
    super.initState();

    school = child.school;
  }

  void _onSelectedSchoolChanged(int value) {
    // ホイールで使用する対象に関する関数
    setState(() {
      // ホイールを回して項目を変える度に更新(更新を反映させるためにこの関数が必要)
      if (value != 0) // 0番目(デフォルトの'学校を選択')でなければ
        school = _schoolName[value]; // 選択中の学校名を設定
    }); // ifが存在しているのは'学校を選択'を一度ホイールを回せば設定できなくさせるため
  }

  /* ホイール */
  void _onTapSchool(BuildContext context) {
    // 返り値なし関数__onTapSchoolを宣言
    showModalBottomSheet(
      // このメソッドによって下から選択するためのシートを作成
      context: context, // 画面を変更させるためにこの画面自身を引数に
      builder: (BuildContext context) {
        // リストの中身の作成
        return Container(
          // heightを設定するためにラッピング
          height: MediaQuery.of(context).size.height /
              4, // 後に呼び出すシートの縦幅を端末の4分の1の大きさに指定
          child: CupertinoPicker.builder(
            // メインの関数、この関数でホイールを作成する
            onSelectedItemChanged:
                _onSelectedSchoolChanged, // ホイールを動かした時のコールバック(選択先の番号がintで引数)
            itemExtent: 40.0, // ホイールで使用する文字の大きさ(項目の大きさ)
            childCount: _schoolName.length, // ホイールで使用する項目の上限
            itemBuilder: (context, index) {
              // ホイールで使用する項目そのもの
              return Text(_schoolName[index]); // 1アイテムの生成
            },
          ),
        );
      },
    );
  }

  /* 遷移元に戻る */
  void handleToBack() {
    Navigator.of(context)
        .pop(Child(child.name, school, child.schoolYear, child.sex));
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
        onTap: () => _onTapSchool(context), // '学校'が書かれている行を押せば右の関数が起動
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSchoolSelect(),
          SizedBox(height: 20), // 縦の間の余白の大きさ
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, // 右端行くやつ
              children: <Widget>[
                ButtonTheme(
                  // ボタンの大きさ
                  minWidth: 100, //必要最小限度の幅
                  height: 40, //長さ
                  child: RaisedButton(
                    //ボタンについての設定
                    onPressed: handleToBack, //押した時のエフェクト
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white, //ボタンの文字
                    shape: StadiumBorder(),
                    child: Text('更新'), //ボタン内の文字
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('学校変更'),
      ),
      body: _buildBody(),
    );
  }
}

/* 学年変更のクラス */
class ChangeYear extends StatefulWidget {
  final Child child;
  ChangeYear({Key key, this.child}) : super(key: key);

  @override
  _ChangeYearState createState() => _ChangeYearState(child);
}

class _ChangeYearState extends State<ChangeYear> {
  /* 引き継いだ情報 */
  final Child child;
  _ChangeYearState(this.child);

  /* 登録する情報 */
  int schoolYear; // 内部の登録学年(内部では1-9で設定)

  /* この中だけで使う変数 */
  String schoolYearLabel;
  List<String> _schoolYearList = [
    //  表面上の学年
    '--- 学年を選択 ---',
    '1年',
    '2年',
    '3年',
  ];

  @override
  void initState() {
    super.initState();

    schoolYear = child.schoolYear;
    if (schoolYear < 7) {
      schoolYearLabel = '${child.schoolYear}年生';
    } else {
      schoolYearLabel = '${child.schoolYear - 6}年生';
    }
  }

  /* ホイールポップアップ */
  void _onTapSchoolYear(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 4,
          child: CupertinoPicker.builder(
            onSelectedItemChanged: _onSelectedYearChanged,
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

  /* 学年更新 */
  void _onSelectedYearChanged(int value) {
    // ホイールで使用する対象に関する関数
    setState(() {
      if (value != 0) schoolYearLabel = _schoolYearList[value];
      schoolYear = value; // 選択中の学年を設定
    }); // ifが存在しているのは'学校を選択'を一度ホイールを回せば設定できなくさせるため
  }

  /* 遷移元に戻る */
  void handleToBack() {
    Navigator.of(context)
        .pop(Child(child.name, child.school, schoolYear + 6, child.sex));
  }

  /* ラベル */
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
        onTap: () => _onTapSchoolYear(context), // '学校'が書かれている行を押せば右の関数が起動
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildYearSelect(),
          SizedBox(height: 20), // 縦の間の余白の大きさ
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, // 右端行くやつ
              children: <Widget>[
                ButtonTheme(
                  // ボタンの大きさ
                  minWidth: 100, //必要最小限度の幅
                  height: 40, //長さ
                  child: RaisedButton(
                    //ボタンについての設定
                    onPressed: handleToBack, //押した時のエフェクト
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white, //ボタンの文字
                    shape: StadiumBorder(),
                    child: Text('更新'), //ボタン内の文字
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('学年変更'),
      ),
      body: _buildBody(),
    );
  }
}

import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:url_launcher/url_launcher.dart';

import 'package:sample/data/strings.dart';

/* インフォメーション画面 */
class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final double head = 25.0; // 大見出し
  final double middleHead = 20.0; // サブ見出し
  final double normal = 16.0; // 本文
  final double lineSpace = 8.0; // 行間

  /* Bodyウィジェット */
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _dataText(), // 利用データについて
          SizedBox(height: lineSpace),
          _personalDataText(), // 個人情報について
        ],
      ),
    );
  }

  /* テキストの汎用クラス */
  Widget _textFormat(
      {@required String text, double fontSize: 16.0, Color color}) {
    if (fontSize == head) {
      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dashed,
          decorationColor: Theme.of(context).primaryColor,
        ),
      );
    } else {
      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
        ),
      );
    }
  }

  /* 利用しているデータについて */
  Widget _dataText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _textFormat(text: InfoStrings.dataTitle, fontSize: head),
        SizedBox(height: lineSpace),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0), // 周りの余白
          child: _textFormat(
            text: InfoStrings.dataLocation + '\n' + InfoStrings.dataAttention,
          ),
        ),
        SizedBox(height: lineSpace),
        _textFormat(text: InfoStrings.openData, fontSize: middleHead),
        SizedBox(height: lineSpace),
        Image.asset('assets/open_data.png'),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () async {
                const url =
                    'http://www.soumu.go.jp/menu_seisaku/ictseisaku/ictriyou/opendata/';
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
              child: _textFormat(
                text: InfoStrings.linkInternalAffairsCommunications,
                fontSize: 8.0,
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
        SizedBox(height: lineSpace),
        _textFormat(text: InfoStrings.usingData, fontSize: middleHead),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: lineSpace),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () async {
                  const url = 'https://illustrain.com/';
                  if (await canLaunch(url)) await launch(url);
                },
                child: _textFormat(
                    text: InfoStrings.illustration1,
                    color: Theme.of(context).accentColor),
              ),
              InkWell(
                onTap: () async {
                  const url = 'https://icooon-mono.com/';
                  if (await canLaunch(url)) await launch(url);
                },
                child: _textFormat(
                    text: InfoStrings.illustration2,
                    color: Theme.of(context).accentColor),
              ),
            ],
          ),
        ),
        SizedBox(height: lineSpace),
        _textFormat(text: InfoStrings.cooperationSchools, fontSize: middleHead),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: lineSpace),
          child: Column(
            children: <Widget>[
              _textFormat(text: InfoStrings.cooperationSchoolsValue[0]),
            ],
          ),
        ),
      ],
    );
  }

  /* 個人情報について */
  Widget _personalDataText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _textFormat(text: InfoStrings.personalTitle, fontSize: head),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('このアプリについて'), // タイトル
      ),
      body: _buildBody(),
    );
  }
}

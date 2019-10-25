import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:url_launcher/url_launcher.dart';

import 'package:sample/data/strings.dart';

/* ヘルプ画面 */
class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final double head = 25.0; // 大見出し
  final double middleHead = 20.0; // サブ見出し
  final double normal = 16.0; // 本文
  final double lineSpace = 8.0; // 行間

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

  /* ５大栄養素について */
  Widget _fiveMajorNutrients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _textFormat(text: HelpStrings.graphTitle, fontSize: head),
        SizedBox(height: lineSpace),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: lineSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _textFormat(text: HelpStrings.graphText + HelpStrings.graphBase),
              SizedBox(height: lineSpace),
              Image.asset('assets/nutrient_base.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      const url =
                          'http://www.mext.go.jp/a_menu/sports/syokuiku/__icsFiles/afieldfile/2019/06/06/1407704_002.pdf';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                    child: _textFormat(
                      text: HelpStrings.nutrientLink,
                      fontSize: 8.0,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
              _textFormat(text: HelpStrings.graphOther),
              Image.asset('assets/zinc_base.png'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _fiveMajorNutrients(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ヘルプ'),
      ),
      body: _buildBody(),
    );
  }
}
import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/child.dart';
import 'package:sample/data/strings.dart';

/* インフォメーション画面 */
class Account extends StatefulWidget {
  final Child child;
  Account({Key key, this.child}) : super(key: key);
  
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          DevelopingStrings.noDevelop,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }
}
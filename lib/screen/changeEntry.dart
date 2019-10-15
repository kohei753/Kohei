import 'package:flutter/material.dart';

import 'package:sample/data/child.dart';
import 'checkEntry.dart';
import 'setting.dart';

/* 名前変更のクラス */
class ChangeName extends StatefulWidget {
  final Child child;
  ChangeName({Key key, this.child}) : super(key: key);

  @override
  _ChangeNameState createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('名前変更'),
      ),
    );
  }
}

/* 性別変更のクラス */
class ChangeSex extends StatefulWidget {
  final Child child;
  ChangeSex({Key key, this.child}) : super(key: key);

  @override
  _ChangeSexState createState() => _ChangeSexState();
}

class _ChangeSexState extends State<ChangeSex> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('性別変更'),
      ),
    );
  }
}

/* 学校変更のクラス */
class ChangeSchool extends StatefulWidget {
  final Child child;
  ChangeSchool({Key key, this.child}) : super(key: key);

  @override
  _ChangeSchoolState createState() => _ChangeSchoolState();
}

class _ChangeSchoolState extends State<ChangeSchool> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('学校変更'),
      ),
    );
  }
}

/* 学年変更のクラス */
class ChangeYear extends StatefulWidget {
  final Child child;
  ChangeYear({Key key, this.child}) : super(key: key);

  @override
  _ChangeYearState createState() => _ChangeYearState();
}

class _ChangeYearState extends State<ChangeYear> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('学年変更'),
      ),
    );
  }
}
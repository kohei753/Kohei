import 'package:flutter/material.dart';

import 'package:sample/data/menu.dart';
import 'package:sample/data/child.dart';
import 'package:sample/data/dri.dart';

class CheckEntry extends StatefulWidget {
  final Map<DateTime, Menu> menus;
  final DRI dri;
  final Child child;
  CheckEntry({Key key, this.menus, this.dri, this.child})
      : super(key: key);

  @override
  _CheckEntryState createState() => _CheckEntryState();
}

class _CheckEntryState extends State<CheckEntry> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold();
  }
}
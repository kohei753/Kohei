import 'package:flutter/material.dart'; // マテリアルデザインしようぜのやーつ

import 'package:sample/data/menu.dart' as menu;
import 'package:sample/data/child.dart' as child;

/* 設定画面 */
class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  /* 表示するリスト */
  final List<Widget> _itemList = [
    ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
      leading: Container(
        child: Icon(
          Icons.person,
          size: 50,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black26,
        ),
      ),
      title: Text(
        '登録情報',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      subtitle: Text('巴中学校'),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {},
    ),
    ListTile(),
  ];

  /* ボディのリスト生成 */
  Widget _buildBodyList() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: _itemList.length,
      itemBuilder: (BuildContext context, int index) {
        return _itemList[index];
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
      ),
      body: _buildBodyList(),
    );
  }
}

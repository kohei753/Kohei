import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:sample/screen/setting.dart';
import 'package:sample/screen/account.dart';
import 'package:sample/data/child.dart';

void main() {
  group('transition', () {
    test('Child infomation should be taken over in setting', () {
      final setting = Setting(child: Child('高橋圭太', '本通中学校', 8, 0));

      expect('高橋圭太', setting.child.name);
      expect('本通中学校', setting.child.school);
      expect(8, setting.child.schoolYear);
      expect(0, setting.child.sex);
    });

    testWidgets('State class is generated correctly', (WidgetTester tester) async {
      Key settingKey = Key('setting');
      Setting settingTest = Setting(
          key: settingKey, child: Child('けいた', '巴中学校', 1, 1));

      await tester.pumpWidget(MaterialApp(home: settingTest));

      final StatefulElement settingElement = tester.element(
          find.byKey(settingKey));
      final settingElementState = settingElement.state;

      // StateWidgetが生成されているか
      expect(find.byKey(settingKey), findsOneWidget);
      // Stateに値を引き継いでいるか
      expect(settingElementState.widget, equals(settingTest));

      // 各メニューのテキストが正しく表示されているか
      expect(find.text('登録情報'), findsOneWidget);
      expect(find.text('原産地'), findsOneWidget);
      expect(find.text('このアプリについて'), findsOneWidget);
      expect(find.text('ヘルプ'), findsOneWidget);
    });
  });
}
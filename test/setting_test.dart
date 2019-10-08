import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:sample/screen/setting.dart';
import 'package:sample/screen/account.dart';
import 'package:sample/data/child.dart';

void main() {
  group('transition', () {
    test('Child infomatio should be taken over in setting', () {
      final setting = Setting(child: Child('高橋圭太', '本通中学校', 8, 0));

      expect('高橋圭太', setting.child.name);
      expect('本通中学校', setting.child.school);
      expect(8, setting.child.schoolYear);
      expect(0, setting.child.sex);
    });

    testWidgets('The correct menu should exist', (WidgetTester tester) async {
      Key settingKey = Key('setting');
      Setting settingTest = Setting(key: settingKey, child: Child('けいた', '巴中学校', 1, 1));

      await tester.pumpWidget(settingTest);

      final StatefulElement settingElement = tester.element(find.byKey(settingKey));
      final settingElementState = settingElement.state;
      
      expect(settingElementState.widget, equals(settingTest));
    });
  });
}
import 'package:realm/realm.dart';
import 'dart:ui';

part 'category.g.dart';

@RealmModel()
class $Category {
  @PrimaryKey()
  late final String name;
  late final int colorValue;

  Color get color {
    return Color(colorValue);
  }

  set color(Color value) {
    colorValue = value.value;
  }
}

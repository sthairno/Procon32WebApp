//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'peace_rotate.g.dart';

class PeaceRotate extends EnumClass {

  /// ピース回転情報
  @BuiltValueEnumConst(wireNumber: 0)
  static const PeaceRotate number0 = _$number0;
  /// ピース回転情報
  @BuiltValueEnumConst(wireNumber: 90)
  static const PeaceRotate number90 = _$number90;
  /// ピース回転情報
  @BuiltValueEnumConst(wireNumber: 180)
  static const PeaceRotate number180 = _$number180;
  /// ピース回転情報
  @BuiltValueEnumConst(wireNumber: 270)
  static const PeaceRotate number270 = _$number270;

  static Serializer<PeaceRotate> get serializer => _$peaceRotateSerializer;

  const PeaceRotate._(String name): super(name);

  static BuiltSet<PeaceRotate> get values => _$values;
  static PeaceRotate valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PeaceRotateMixin = Object with _$PeaceRotateMixin;


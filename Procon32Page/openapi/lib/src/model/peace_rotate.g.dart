// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peace_rotate.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PeaceRotate _$number0 = const PeaceRotate._('number0');
const PeaceRotate _$number90 = const PeaceRotate._('number90');
const PeaceRotate _$number180 = const PeaceRotate._('number180');
const PeaceRotate _$number270 = const PeaceRotate._('number270');

PeaceRotate _$valueOf(String name) {
  switch (name) {
    case 'number0':
      return _$number0;
    case 'number90':
      return _$number90;
    case 'number180':
      return _$number180;
    case 'number270':
      return _$number270;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<PeaceRotate> _$values =
    new BuiltSet<PeaceRotate>(const <PeaceRotate>[
  _$number0,
  _$number90,
  _$number180,
  _$number270,
]);

class _$PeaceRotateMeta {
  const _$PeaceRotateMeta();
  PeaceRotate get number0 => _$number0;
  PeaceRotate get number90 => _$number90;
  PeaceRotate get number180 => _$number180;
  PeaceRotate get number270 => _$number270;
  PeaceRotate valueOf(String name) => _$valueOf(name);
  BuiltSet<PeaceRotate> get values => _$values;
}

abstract class _$PeaceRotateMixin {
  // ignore: non_constant_identifier_names
  _$PeaceRotateMeta get PeaceRotate => const _$PeaceRotateMeta();
}

Serializer<PeaceRotate> _$peaceRotateSerializer = new _$PeaceRotateSerializer();

class _$PeaceRotateSerializer implements PrimitiveSerializer<PeaceRotate> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number0': 0,
    'number90': 90,
    'number180': 180,
    'number270': 270,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    0: 'number0',
    90: 'number90',
    180: 'number180',
    270: 'number270',
  };

  @override
  final Iterable<Type> types = const <Type>[PeaceRotate];
  @override
  final String wireName = 'PeaceRotate';

  @override
  Object serialize(Serializers serializers, PeaceRotate object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PeaceRotate deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PeaceRotate.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

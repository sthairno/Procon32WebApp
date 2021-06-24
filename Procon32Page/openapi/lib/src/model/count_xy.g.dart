// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count_xy.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CountXY extends CountXY {
  @override
  final int x;
  @override
  final int y;

  factory _$CountXY([void Function(CountXYBuilder)? updates]) =>
      (new CountXYBuilder()..update(updates)).build();

  _$CountXY._({required this.x, required this.y}) : super._() {
    BuiltValueNullFieldError.checkNotNull(x, 'CountXY', 'x');
    BuiltValueNullFieldError.checkNotNull(y, 'CountXY', 'y');
  }

  @override
  CountXY rebuild(void Function(CountXYBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CountXYBuilder toBuilder() => new CountXYBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CountXY && x == other.x && y == other.y;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, x.hashCode), y.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CountXY')..add('x', x)..add('y', y))
        .toString();
  }
}

class CountXYBuilder implements Builder<CountXY, CountXYBuilder> {
  _$CountXY? _$v;

  int? _x;
  int? get x => _$this._x;
  set x(int? x) => _$this._x = x;

  int? _y;
  int? get y => _$this._y;
  set y(int? y) => _$this._y = y;

  CountXYBuilder() {
    CountXY._initializeBuilder(this);
  }

  CountXYBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _x = $v.x;
      _y = $v.y;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CountXY other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CountXY;
  }

  @override
  void update(void Function(CountXYBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CountXY build() {
    final _$result = _$v ??
        new _$CountXY._(
            x: BuiltValueNullFieldError.checkNotNull(x, 'CountXY', 'x'),
            y: BuiltValueNullFieldError.checkNotNull(y, 'CountXY', 'y'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

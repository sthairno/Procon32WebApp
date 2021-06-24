// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Size extends Size {
  @override
  final int? width;
  @override
  final int? height;

  factory _$Size([void Function(SizeBuilder)? updates]) =>
      (new SizeBuilder()..update(updates)).build();

  _$Size._({this.width, this.height}) : super._();

  @override
  Size rebuild(void Function(SizeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SizeBuilder toBuilder() => new SizeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Size && width == other.width && height == other.height;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, width.hashCode), height.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Size')
          ..add('width', width)
          ..add('height', height))
        .toString();
  }
}

class SizeBuilder implements Builder<Size, SizeBuilder> {
  _$Size? _$v;

  int? _width;
  int? get width => _$this._width;
  set width(int? width) => _$this._width = width;

  int? _height;
  int? get height => _$this._height;
  set height(int? height) => _$this._height = height;

  SizeBuilder() {
    Size._initializeBuilder(this);
  }

  SizeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _width = $v.width;
      _height = $v.height;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Size other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Size;
  }

  @override
  void update(void Function(SizeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Size build() {
    final _$result = _$v ?? new _$Size._(width: width, height: height);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

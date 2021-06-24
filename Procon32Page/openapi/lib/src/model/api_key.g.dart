// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_key.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$APIKey extends APIKey {
  @override
  final String? key;
  @override
  final String? userID;
  @override
  final DateTime? updatedDateTime;

  factory _$APIKey([void Function(APIKeyBuilder)? updates]) =>
      (new APIKeyBuilder()..update(updates)).build();

  _$APIKey._({this.key, this.userID, this.updatedDateTime}) : super._();

  @override
  APIKey rebuild(void Function(APIKeyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  APIKeyBuilder toBuilder() => new APIKeyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is APIKey &&
        key == other.key &&
        userID == other.userID &&
        updatedDateTime == other.updatedDateTime;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, key.hashCode), userID.hashCode), updatedDateTime.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('APIKey')
          ..add('key', key)
          ..add('userID', userID)
          ..add('updatedDateTime', updatedDateTime))
        .toString();
  }
}

class APIKeyBuilder implements Builder<APIKey, APIKeyBuilder> {
  _$APIKey? _$v;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  String? _userID;
  String? get userID => _$this._userID;
  set userID(String? userID) => _$this._userID = userID;

  DateTime? _updatedDateTime;
  DateTime? get updatedDateTime => _$this._updatedDateTime;
  set updatedDateTime(DateTime? updatedDateTime) =>
      _$this._updatedDateTime = updatedDateTime;

  APIKeyBuilder() {
    APIKey._initializeBuilder(this);
  }

  APIKeyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _key = $v.key;
      _userID = $v.userID;
      _updatedDateTime = $v.updatedDateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(APIKey other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$APIKey;
  }

  @override
  void update(void Function(APIKeyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$APIKey build() {
    final _$result = _$v ??
        new _$APIKey._(
            key: key, userID: userID, updatedDateTime: updatedDateTime);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

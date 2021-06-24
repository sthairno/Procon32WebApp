// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$User extends User {
  @override
  final String? userID;
  @override
  final String displayName;
  @override
  final DateTime? createdDateTime;

  factory _$User([void Function(UserBuilder)? updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._({this.userID, required this.displayName, this.createdDateTime})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(displayName, 'User', 'displayName');
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        userID == other.userID &&
        displayName == other.displayName &&
        createdDateTime == other.createdDateTime;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, userID.hashCode), displayName.hashCode),
        createdDateTime.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('userID', userID)
          ..add('displayName', displayName)
          ..add('createdDateTime', createdDateTime))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User? _$v;

  String? _userID;
  String? get userID => _$this._userID;
  set userID(String? userID) => _$this._userID = userID;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  DateTime? _createdDateTime;
  DateTime? get createdDateTime => _$this._createdDateTime;
  set createdDateTime(DateTime? createdDateTime) =>
      _$this._createdDateTime = createdDateTime;

  UserBuilder() {
    User._initializeBuilder(this);
  }

  UserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userID = $v.userID;
      _displayName = $v.displayName;
      _createdDateTime = $v.createdDateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    final _$result = _$v ??
        new _$User._(
            userID: userID,
            displayName: BuiltValueNullFieldError.checkNotNull(
                displayName, 'User', 'displayName'),
            createdDateTime: createdDateTime);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

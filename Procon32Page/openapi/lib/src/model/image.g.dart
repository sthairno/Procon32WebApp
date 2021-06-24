// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Image extends Image {
  @override
  final String? id;
  @override
  final DateTime? createdDateTime;
  @override
  final String? createdUserId;
  @override
  final Size? size;
  @override
  final String? rawFilePath;
  @override
  final String? thumbnailFilePath;

  factory _$Image([void Function(ImageBuilder)? updates]) =>
      (new ImageBuilder()..update(updates)).build();

  _$Image._(
      {this.id,
      this.createdDateTime,
      this.createdUserId,
      this.size,
      this.rawFilePath,
      this.thumbnailFilePath})
      : super._();

  @override
  Image rebuild(void Function(ImageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ImageBuilder toBuilder() => new ImageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Image &&
        id == other.id &&
        createdDateTime == other.createdDateTime &&
        createdUserId == other.createdUserId &&
        size == other.size &&
        rawFilePath == other.rawFilePath &&
        thumbnailFilePath == other.thumbnailFilePath;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, id.hashCode), createdDateTime.hashCode),
                    createdUserId.hashCode),
                size.hashCode),
            rawFilePath.hashCode),
        thumbnailFilePath.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Image')
          ..add('id', id)
          ..add('createdDateTime', createdDateTime)
          ..add('createdUserId', createdUserId)
          ..add('size', size)
          ..add('rawFilePath', rawFilePath)
          ..add('thumbnailFilePath', thumbnailFilePath))
        .toString();
  }
}

class ImageBuilder implements Builder<Image, ImageBuilder> {
  _$Image? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDateTime;
  DateTime? get createdDateTime => _$this._createdDateTime;
  set createdDateTime(DateTime? createdDateTime) =>
      _$this._createdDateTime = createdDateTime;

  String? _createdUserId;
  String? get createdUserId => _$this._createdUserId;
  set createdUserId(String? createdUserId) =>
      _$this._createdUserId = createdUserId;

  SizeBuilder? _size;
  SizeBuilder get size => _$this._size ??= new SizeBuilder();
  set size(SizeBuilder? size) => _$this._size = size;

  String? _rawFilePath;
  String? get rawFilePath => _$this._rawFilePath;
  set rawFilePath(String? rawFilePath) => _$this._rawFilePath = rawFilePath;

  String? _thumbnailFilePath;
  String? get thumbnailFilePath => _$this._thumbnailFilePath;
  set thumbnailFilePath(String? thumbnailFilePath) =>
      _$this._thumbnailFilePath = thumbnailFilePath;

  ImageBuilder() {
    Image._initializeBuilder(this);
  }

  ImageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDateTime = $v.createdDateTime;
      _createdUserId = $v.createdUserId;
      _size = $v.size?.toBuilder();
      _rawFilePath = $v.rawFilePath;
      _thumbnailFilePath = $v.thumbnailFilePath;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Image other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Image;
  }

  @override
  void update(void Function(ImageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Image build() {
    _$Image _$result;
    try {
      _$result = _$v ??
          new _$Image._(
              id: id,
              createdDateTime: createdDateTime,
              createdUserId: createdUserId,
              size: _size?.build(),
              rawFilePath: rawFilePath,
              thumbnailFilePath: thumbnailFilePath);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'size';
        _size?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Image', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

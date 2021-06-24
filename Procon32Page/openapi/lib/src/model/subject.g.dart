// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Subject extends Subject {
  @override
  final String? id;
  @override
  final String? createdUserId;
  @override
  final DateTime? createdDateTime;
  @override
  final Size? size;
  @override
  final String? subjectFilePath;
  @override
  final String? previewFilePath;
  @override
  final String? thumbnailFilePath;
  @override
  final Image? baseImage;
  @override
  final String baseImageId;
  @override
  final String name;
  @override
  final int maxSelectCount;
  @override
  final int selectionCost;
  @override
  final int swapCost;
  @override
  final CountXY peaceCount;
  @override
  final BuiltList<BuiltList<String>> indexes;
  @override
  final BuiltList<BuiltList<PeaceRotate>> rotations;

  factory _$Subject([void Function(SubjectBuilder)? updates]) =>
      (new SubjectBuilder()..update(updates)).build();

  _$Subject._(
      {this.id,
      this.createdUserId,
      this.createdDateTime,
      this.size,
      this.subjectFilePath,
      this.previewFilePath,
      this.thumbnailFilePath,
      this.baseImage,
      required this.baseImageId,
      required this.name,
      required this.maxSelectCount,
      required this.selectionCost,
      required this.swapCost,
      required this.peaceCount,
      required this.indexes,
      required this.rotations})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        baseImageId, 'Subject', 'baseImageId');
    BuiltValueNullFieldError.checkNotNull(name, 'Subject', 'name');
    BuiltValueNullFieldError.checkNotNull(
        maxSelectCount, 'Subject', 'maxSelectCount');
    BuiltValueNullFieldError.checkNotNull(
        selectionCost, 'Subject', 'selectionCost');
    BuiltValueNullFieldError.checkNotNull(swapCost, 'Subject', 'swapCost');
    BuiltValueNullFieldError.checkNotNull(peaceCount, 'Subject', 'peaceCount');
    BuiltValueNullFieldError.checkNotNull(indexes, 'Subject', 'indexes');
    BuiltValueNullFieldError.checkNotNull(rotations, 'Subject', 'rotations');
  }

  @override
  Subject rebuild(void Function(SubjectBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectBuilder toBuilder() => new SubjectBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Subject &&
        id == other.id &&
        createdUserId == other.createdUserId &&
        createdDateTime == other.createdDateTime &&
        size == other.size &&
        subjectFilePath == other.subjectFilePath &&
        previewFilePath == other.previewFilePath &&
        thumbnailFilePath == other.thumbnailFilePath &&
        baseImage == other.baseImage &&
        baseImageId == other.baseImageId &&
        name == other.name &&
        maxSelectCount == other.maxSelectCount &&
        selectionCost == other.selectionCost &&
        swapCost == other.swapCost &&
        peaceCount == other.peaceCount &&
        indexes == other.indexes &&
        rotations == other.rotations;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    0,
                                                                    id
                                                                        .hashCode),
                                                                createdUserId
                                                                    .hashCode),
                                                            createdDateTime
                                                                .hashCode),
                                                        size.hashCode),
                                                    subjectFilePath.hashCode),
                                                previewFilePath.hashCode),
                                            thumbnailFilePath.hashCode),
                                        baseImage.hashCode),
                                    baseImageId.hashCode),
                                name.hashCode),
                            maxSelectCount.hashCode),
                        selectionCost.hashCode),
                    swapCost.hashCode),
                peaceCount.hashCode),
            indexes.hashCode),
        rotations.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Subject')
          ..add('id', id)
          ..add('createdUserId', createdUserId)
          ..add('createdDateTime', createdDateTime)
          ..add('size', size)
          ..add('subjectFilePath', subjectFilePath)
          ..add('previewFilePath', previewFilePath)
          ..add('thumbnailFilePath', thumbnailFilePath)
          ..add('baseImage', baseImage)
          ..add('baseImageId', baseImageId)
          ..add('name', name)
          ..add('maxSelectCount', maxSelectCount)
          ..add('selectionCost', selectionCost)
          ..add('swapCost', swapCost)
          ..add('peaceCount', peaceCount)
          ..add('indexes', indexes)
          ..add('rotations', rotations))
        .toString();
  }
}

class SubjectBuilder implements Builder<Subject, SubjectBuilder> {
  _$Subject? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _createdUserId;
  String? get createdUserId => _$this._createdUserId;
  set createdUserId(String? createdUserId) =>
      _$this._createdUserId = createdUserId;

  DateTime? _createdDateTime;
  DateTime? get createdDateTime => _$this._createdDateTime;
  set createdDateTime(DateTime? createdDateTime) =>
      _$this._createdDateTime = createdDateTime;

  SizeBuilder? _size;
  SizeBuilder get size => _$this._size ??= new SizeBuilder();
  set size(SizeBuilder? size) => _$this._size = size;

  String? _subjectFilePath;
  String? get subjectFilePath => _$this._subjectFilePath;
  set subjectFilePath(String? subjectFilePath) =>
      _$this._subjectFilePath = subjectFilePath;

  String? _previewFilePath;
  String? get previewFilePath => _$this._previewFilePath;
  set previewFilePath(String? previewFilePath) =>
      _$this._previewFilePath = previewFilePath;

  String? _thumbnailFilePath;
  String? get thumbnailFilePath => _$this._thumbnailFilePath;
  set thumbnailFilePath(String? thumbnailFilePath) =>
      _$this._thumbnailFilePath = thumbnailFilePath;

  ImageBuilder? _baseImage;
  ImageBuilder get baseImage => _$this._baseImage ??= new ImageBuilder();
  set baseImage(ImageBuilder? baseImage) => _$this._baseImage = baseImage;

  String? _baseImageId;
  String? get baseImageId => _$this._baseImageId;
  set baseImageId(String? baseImageId) => _$this._baseImageId = baseImageId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _maxSelectCount;
  int? get maxSelectCount => _$this._maxSelectCount;
  set maxSelectCount(int? maxSelectCount) =>
      _$this._maxSelectCount = maxSelectCount;

  int? _selectionCost;
  int? get selectionCost => _$this._selectionCost;
  set selectionCost(int? selectionCost) =>
      _$this._selectionCost = selectionCost;

  int? _swapCost;
  int? get swapCost => _$this._swapCost;
  set swapCost(int? swapCost) => _$this._swapCost = swapCost;

  CountXYBuilder? _peaceCount;
  CountXYBuilder get peaceCount => _$this._peaceCount ??= new CountXYBuilder();
  set peaceCount(CountXYBuilder? peaceCount) => _$this._peaceCount = peaceCount;

  ListBuilder<BuiltList<String>>? _indexes;
  ListBuilder<BuiltList<String>> get indexes =>
      _$this._indexes ??= new ListBuilder<BuiltList<String>>();
  set indexes(ListBuilder<BuiltList<String>>? indexes) =>
      _$this._indexes = indexes;

  ListBuilder<BuiltList<PeaceRotate>>? _rotations;
  ListBuilder<BuiltList<PeaceRotate>> get rotations =>
      _$this._rotations ??= new ListBuilder<BuiltList<PeaceRotate>>();
  set rotations(ListBuilder<BuiltList<PeaceRotate>>? rotations) =>
      _$this._rotations = rotations;

  SubjectBuilder() {
    Subject._initializeBuilder(this);
  }

  SubjectBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdUserId = $v.createdUserId;
      _createdDateTime = $v.createdDateTime;
      _size = $v.size?.toBuilder();
      _subjectFilePath = $v.subjectFilePath;
      _previewFilePath = $v.previewFilePath;
      _thumbnailFilePath = $v.thumbnailFilePath;
      _baseImage = $v.baseImage?.toBuilder();
      _baseImageId = $v.baseImageId;
      _name = $v.name;
      _maxSelectCount = $v.maxSelectCount;
      _selectionCost = $v.selectionCost;
      _swapCost = $v.swapCost;
      _peaceCount = $v.peaceCount.toBuilder();
      _indexes = $v.indexes.toBuilder();
      _rotations = $v.rotations.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Subject other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Subject;
  }

  @override
  void update(void Function(SubjectBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Subject build() {
    _$Subject _$result;
    try {
      _$result = _$v ??
          new _$Subject._(
              id: id,
              createdUserId: createdUserId,
              createdDateTime: createdDateTime,
              size: _size?.build(),
              subjectFilePath: subjectFilePath,
              previewFilePath: previewFilePath,
              thumbnailFilePath: thumbnailFilePath,
              baseImage: _baseImage?.build(),
              baseImageId: BuiltValueNullFieldError.checkNotNull(
                  baseImageId, 'Subject', 'baseImageId'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, 'Subject', 'name'),
              maxSelectCount: BuiltValueNullFieldError.checkNotNull(
                  maxSelectCount, 'Subject', 'maxSelectCount'),
              selectionCost: BuiltValueNullFieldError.checkNotNull(
                  selectionCost, 'Subject', 'selectionCost'),
              swapCost: BuiltValueNullFieldError.checkNotNull(
                  swapCost, 'Subject', 'swapCost'),
              peaceCount: peaceCount.build(),
              indexes: indexes.build(),
              rotations: rotations.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'size';
        _size?.build();

        _$failedField = 'baseImage';
        _baseImage?.build();

        _$failedField = 'peaceCount';
        peaceCount.build();
        _$failedField = 'indexes';
        indexes.build();
        _$failedField = 'rotations';
        rotations.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Subject', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

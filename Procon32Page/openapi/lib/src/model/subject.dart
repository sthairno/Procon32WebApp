//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:openapi/src/model/count_xy.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/image.dart';
import 'package:openapi/src/model/peace_rotate.dart';
import 'package:openapi/src/model/size.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'subject.g.dart';



abstract class Subject implements Built<Subject, SubjectBuilder> {
    /// 課題ID
    @BuiltValueField(wireName: r'id')
    String? get id;

    /// 作成者ユーザーID
    @BuiltValueField(wireName: r'createdUserId')
    String? get createdUserId;

    /// 作成日
    @BuiltValueField(wireName: r'createdDateTime')
    DateTime? get createdDateTime;

    @BuiltValueField(wireName: r'size')
    Size? get size;

    /// 課題ファイルパス
    @BuiltValueField(wireName: r'subjectFilePath')
    String? get subjectFilePath;

    /// プレビュー画像パス
    @BuiltValueField(wireName: r'previewFilePath')
    String? get previewFilePath;

    /// サムネイル画像パス
    @BuiltValueField(wireName: r'thumbnailFilePath')
    String? get thumbnailFilePath;

    @BuiltValueField(wireName: r'baseImage')
    Image? get baseImage;

    /// 原画像ID
    @BuiltValueField(wireName: r'baseImageId')
    String get baseImageId;

    /// 表示名
    @BuiltValueField(wireName: r'name')
    String get name;

    /// 最大選択回数
    @BuiltValueField(wireName: r'maxSelectCount')
    int get maxSelectCount;

    /// 選択コスト
    @BuiltValueField(wireName: r'selectionCost')
    int get selectionCost;

    /// 交換コスト
    @BuiltValueField(wireName: r'swapCost')
    int get swapCost;

    @BuiltValueField(wireName: r'peaceCount')
    CountXY get peaceCount;

    /// 各ピースの位置情報
    @BuiltValueField(wireName: r'indexes')
    BuiltList<BuiltList<String>> get indexes;

    /// 各ピースの回転情報
    @BuiltValueField(wireName: r'rotations')
    BuiltList<BuiltList<PeaceRotate>> get rotations;

    Subject._();

    static void _initializeBuilder(SubjectBuilder b) => b;

    factory Subject([void updates(SubjectBuilder b)]) = _$Subject;

    @BuiltValueSerializer(custom: true)
    static Serializer<Subject> get serializer => _$SubjectSerializer();
}

class _$SubjectSerializer implements StructuredSerializer<Subject> {
    @override
    final Iterable<Type> types = const [Subject, _$Subject];

    @override
    final String wireName = r'Subject';

    @override
    Iterable<Object?> serialize(Serializers serializers, Subject object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.id != null) {
            result
                ..add(r'id')
                ..add(serializers.serialize(object.id,
                    specifiedType: const FullType(String)));
        }
        if (object.createdUserId != null) {
            result
                ..add(r'createdUserId')
                ..add(serializers.serialize(object.createdUserId,
                    specifiedType: const FullType(String)));
        }
        if (object.createdDateTime != null) {
            result
                ..add(r'createdDateTime')
                ..add(serializers.serialize(object.createdDateTime,
                    specifiedType: const FullType(DateTime)));
        }
        if (object.size != null) {
            result
                ..add(r'size')
                ..add(serializers.serialize(object.size,
                    specifiedType: const FullType(Size)));
        }
        if (object.subjectFilePath != null) {
            result
                ..add(r'subjectFilePath')
                ..add(serializers.serialize(object.subjectFilePath,
                    specifiedType: const FullType(String)));
        }
        if (object.previewFilePath != null) {
            result
                ..add(r'previewFilePath')
                ..add(serializers.serialize(object.previewFilePath,
                    specifiedType: const FullType(String)));
        }
        if (object.thumbnailFilePath != null) {
            result
                ..add(r'thumbnailFilePath')
                ..add(serializers.serialize(object.thumbnailFilePath,
                    specifiedType: const FullType(String)));
        }
        if (object.baseImage != null) {
            result
                ..add(r'baseImage')
                ..add(serializers.serialize(object.baseImage,
                    specifiedType: const FullType(Image)));
        }
        result
            ..add(r'baseImageId')
            ..add(serializers.serialize(object.baseImageId,
                specifiedType: const FullType(String)));
        result
            ..add(r'name')
            ..add(serializers.serialize(object.name,
                specifiedType: const FullType(String)));
        result
            ..add(r'maxSelectCount')
            ..add(serializers.serialize(object.maxSelectCount,
                specifiedType: const FullType(int)));
        result
            ..add(r'selectionCost')
            ..add(serializers.serialize(object.selectionCost,
                specifiedType: const FullType(int)));
        result
            ..add(r'swapCost')
            ..add(serializers.serialize(object.swapCost,
                specifiedType: const FullType(int)));
        result
            ..add(r'peaceCount')
            ..add(serializers.serialize(object.peaceCount,
                specifiedType: const FullType(CountXY)));
        result
            ..add(r'indexes')
            ..add(serializers.serialize(object.indexes,
                specifiedType: const FullType(BuiltList, [FullType(BuiltList, [FullType(String)])])));
        result
            ..add(r'rotations')
            ..add(serializers.serialize(object.rotations,
                specifiedType: const FullType(BuiltList, [FullType(BuiltList, [FullType(PeaceRotate)])])));
        return result;
    }

    @override
    Subject deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SubjectBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'id':
                    result.id = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'createdUserId':
                    result.createdUserId = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'createdDateTime':
                    result.createdDateTime = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    break;
                case r'size':
                    result.size.replace(serializers.deserialize(value,
                        specifiedType: const FullType(Size)) as Size);
                    break;
                case r'subjectFilePath':
                    result.subjectFilePath = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'previewFilePath':
                    result.previewFilePath = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'thumbnailFilePath':
                    result.thumbnailFilePath = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'baseImage':
                    result.baseImage.replace(serializers.deserialize(value,
                        specifiedType: const FullType(Image)) as Image);
                    break;
                case r'baseImageId':
                    result.baseImageId = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'name':
                    result.name = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'maxSelectCount':
                    result.maxSelectCount = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'selectionCost':
                    result.selectionCost = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'swapCost':
                    result.swapCost = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'peaceCount':
                    result.peaceCount.replace(serializers.deserialize(value,
                        specifiedType: const FullType(CountXY)) as CountXY);
                    break;
                case r'indexes':
                    result.indexes.replace(serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(BuiltList, [FullType(String)])])) as BuiltList<BuiltList<String>>);
                    break;
                case r'rotations':
                    result.rotations.replace(serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(BuiltList, [FullType(PeaceRotate)])])) as BuiltList<BuiltList<PeaceRotate>>);
                    break;
            }
        }
        return result.build();
    }
}


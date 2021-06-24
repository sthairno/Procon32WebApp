//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:openapi/src/model/size.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'image.g.dart';



abstract class Image implements Built<Image, ImageBuilder> {
    /// 画像ID
    @BuiltValueField(wireName: r'id')
    String? get id;

    /// 作成日
    @BuiltValueField(wireName: r'createdDateTime')
    DateTime? get createdDateTime;

    /// 作成者ユーザー
    @BuiltValueField(wireName: r'createdUserId')
    String? get createdUserId;

    @BuiltValueField(wireName: r'size')
    Size? get size;

    /// 画像ファイルパス
    @BuiltValueField(wireName: r'rawFilePath')
    String? get rawFilePath;

    /// サムネイル画像パス
    @BuiltValueField(wireName: r'thumbnailFilePath')
    String? get thumbnailFilePath;

    Image._();

    static void _initializeBuilder(ImageBuilder b) => b;

    factory Image([void updates(ImageBuilder b)]) = _$Image;

    @BuiltValueSerializer(custom: true)
    static Serializer<Image> get serializer => _$ImageSerializer();
}

class _$ImageSerializer implements StructuredSerializer<Image> {
    @override
    final Iterable<Type> types = const [Image, _$Image];

    @override
    final String wireName = r'Image';

    @override
    Iterable<Object?> serialize(Serializers serializers, Image object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.id != null) {
            result
                ..add(r'id')
                ..add(serializers.serialize(object.id,
                    specifiedType: const FullType(String)));
        }
        if (object.createdDateTime != null) {
            result
                ..add(r'createdDateTime')
                ..add(serializers.serialize(object.createdDateTime,
                    specifiedType: const FullType(DateTime)));
        }
        if (object.createdUserId != null) {
            result
                ..add(r'createdUserId')
                ..add(serializers.serialize(object.createdUserId,
                    specifiedType: const FullType(String)));
        }
        if (object.size != null) {
            result
                ..add(r'size')
                ..add(serializers.serialize(object.size,
                    specifiedType: const FullType(Size)));
        }
        if (object.rawFilePath != null) {
            result
                ..add(r'rawFilePath')
                ..add(serializers.serialize(object.rawFilePath,
                    specifiedType: const FullType(String)));
        }
        if (object.thumbnailFilePath != null) {
            result
                ..add(r'thumbnailFilePath')
                ..add(serializers.serialize(object.thumbnailFilePath,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    Image deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = ImageBuilder();

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
                case r'createdDateTime':
                    result.createdDateTime = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    break;
                case r'createdUserId':
                    result.createdUserId = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'size':
                    result.size.replace(serializers.deserialize(value,
                        specifiedType: const FullType(Size)) as Size);
                    break;
                case r'rawFilePath':
                    result.rawFilePath = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'thumbnailFilePath':
                    result.thumbnailFilePath = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}


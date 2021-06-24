//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_key.g.dart';



abstract class APIKey implements Built<APIKey, APIKeyBuilder> {
    /// APIキーの値
    @BuiltValueField(wireName: r'key')
    String? get key;

    /// APIキーに関連付けられたユーザーID
    @BuiltValueField(wireName: r'userID')
    String? get userID;

    /// 更新日
    @BuiltValueField(wireName: r'updatedDateTime')
    DateTime? get updatedDateTime;

    APIKey._();

    static void _initializeBuilder(APIKeyBuilder b) => b;

    factory APIKey([void updates(APIKeyBuilder b)]) = _$APIKey;

    @BuiltValueSerializer(custom: true)
    static Serializer<APIKey> get serializer => _$APIKeySerializer();
}

class _$APIKeySerializer implements StructuredSerializer<APIKey> {
    @override
    final Iterable<Type> types = const [APIKey, _$APIKey];

    @override
    final String wireName = r'APIKey';

    @override
    Iterable<Object?> serialize(Serializers serializers, APIKey object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.key != null) {
            result
                ..add(r'key')
                ..add(serializers.serialize(object.key,
                    specifiedType: const FullType(String)));
        }
        if (object.userID != null) {
            result
                ..add(r'userID')
                ..add(serializers.serialize(object.userID,
                    specifiedType: const FullType(String)));
        }
        if (object.updatedDateTime != null) {
            result
                ..add(r'updatedDateTime')
                ..add(serializers.serialize(object.updatedDateTime,
                    specifiedType: const FullType(DateTime)));
        }
        return result;
    }

    @override
    APIKey deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = APIKeyBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'key':
                    result.key = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'userID':
                    result.userID = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'updatedDateTime':
                    result.updatedDateTime = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    break;
            }
        }
        return result.build();
    }
}


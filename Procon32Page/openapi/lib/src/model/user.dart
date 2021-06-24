//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';



abstract class User implements Built<User, UserBuilder> {
    /// ユーザー固有のID
    @BuiltValueField(wireName: r'userID')
    String? get userID;

    /// ユーザー指定の表示名
    @BuiltValueField(wireName: r'displayName')
    String get displayName;

    /// ユーザーの作成日
    @BuiltValueField(wireName: r'createdDateTime')
    DateTime? get createdDateTime;

    User._();

    static void _initializeBuilder(UserBuilder b) => b;

    factory User([void updates(UserBuilder b)]) = _$User;

    @BuiltValueSerializer(custom: true)
    static Serializer<User> get serializer => _$UserSerializer();
}

class _$UserSerializer implements StructuredSerializer<User> {
    @override
    final Iterable<Type> types = const [User, _$User];

    @override
    final String wireName = r'User';

    @override
    Iterable<Object?> serialize(Serializers serializers, User object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.userID != null) {
            result
                ..add(r'userID')
                ..add(serializers.serialize(object.userID,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'displayName')
            ..add(serializers.serialize(object.displayName,
                specifiedType: const FullType(String)));
        if (object.createdDateTime != null) {
            result
                ..add(r'createdDateTime')
                ..add(serializers.serialize(object.createdDateTime,
                    specifiedType: const FullType(DateTime)));
        }
        return result;
    }

    @override
    User deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = UserBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'userID':
                    result.userID = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'displayName':
                    result.displayName = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'createdDateTime':
                    result.createdDateTime = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    break;
            }
        }
        return result.build();
    }
}


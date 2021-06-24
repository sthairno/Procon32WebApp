//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'count_xy.g.dart';



abstract class CountXY implements Built<CountXY, CountXYBuilder> {
    /// X方向の個数
    @BuiltValueField(wireName: r'x')
    int get x;

    /// Y方向の個数
    @BuiltValueField(wireName: r'y')
    int get y;

    CountXY._();

    static void _initializeBuilder(CountXYBuilder b) => b;

    factory CountXY([void updates(CountXYBuilder b)]) = _$CountXY;

    @BuiltValueSerializer(custom: true)
    static Serializer<CountXY> get serializer => _$CountXYSerializer();
}

class _$CountXYSerializer implements StructuredSerializer<CountXY> {
    @override
    final Iterable<Type> types = const [CountXY, _$CountXY];

    @override
    final String wireName = r'CountXY';

    @override
    Iterable<Object?> serialize(Serializers serializers, CountXY object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'x')
            ..add(serializers.serialize(object.x,
                specifiedType: const FullType(int)));
        result
            ..add(r'y')
            ..add(serializers.serialize(object.y,
                specifiedType: const FullType(int)));
        return result;
    }

    @override
    CountXY deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = CountXYBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'x':
                    result.x = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'y':
                    result.y = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
            }
        }
        return result.build();
    }
}


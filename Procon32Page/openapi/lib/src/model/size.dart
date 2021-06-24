//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'size.g.dart';



abstract class Size implements Built<Size, SizeBuilder> {
    /// 横幅
    @BuiltValueField(wireName: r'width')
    int? get width;

    /// 縦幅
    @BuiltValueField(wireName: r'height')
    int? get height;

    Size._();

    static void _initializeBuilder(SizeBuilder b) => b;

    factory Size([void updates(SizeBuilder b)]) = _$Size;

    @BuiltValueSerializer(custom: true)
    static Serializer<Size> get serializer => _$SizeSerializer();
}

class _$SizeSerializer implements StructuredSerializer<Size> {
    @override
    final Iterable<Type> types = const [Size, _$Size];

    @override
    final String wireName = r'Size';

    @override
    Iterable<Object?> serialize(Serializers serializers, Size object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.width != null) {
            result
                ..add(r'width')
                ..add(serializers.serialize(object.width,
                    specifiedType: const FullType(int)));
        }
        if (object.height != null) {
            result
                ..add(r'height')
                ..add(serializers.serialize(object.height,
                    specifiedType: const FullType(int)));
        }
        return result;
    }

    @override
    Size deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SizeBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'width':
                    result.width = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'height':
                    result.height = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
            }
        }
        return result.build();
    }
}


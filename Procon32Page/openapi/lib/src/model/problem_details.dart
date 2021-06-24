//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'problem_details.g.dart';



abstract class ProblemDetails implements Built<ProblemDetails, ProblemDetailsBuilder> {
    @BuiltValueField(wireName: r'type')
    String? get type;

    @BuiltValueField(wireName: r'title')
    String? get title;

    @BuiltValueField(wireName: r'status')
    int? get status;

    @BuiltValueField(wireName: r'detail')
    String? get detail;

    @BuiltValueField(wireName: r'instance')
    String? get instance;

    ProblemDetails._();

    static void _initializeBuilder(ProblemDetailsBuilder b) => b;

    factory ProblemDetails([void updates(ProblemDetailsBuilder b)]) = _$ProblemDetails;

    @BuiltValueSerializer(custom: true)
    static Serializer<ProblemDetails> get serializer => _$ProblemDetailsSerializer();
}

class _$ProblemDetailsSerializer implements StructuredSerializer<ProblemDetails> {
    @override
    final Iterable<Type> types = const [ProblemDetails, _$ProblemDetails];

    @override
    final String wireName = r'ProblemDetails';

    @override
    Iterable<Object?> serialize(Serializers serializers, ProblemDetails object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.type != null) {
            result
                ..add(r'type')
                ..add(serializers.serialize(object.type,
                    specifiedType: const FullType(String)));
        }
        if (object.title != null) {
            result
                ..add(r'title')
                ..add(serializers.serialize(object.title,
                    specifiedType: const FullType(String)));
        }
        if (object.status != null) {
            result
                ..add(r'status')
                ..add(serializers.serialize(object.status,
                    specifiedType: const FullType(int)));
        }
        if (object.detail != null) {
            result
                ..add(r'detail')
                ..add(serializers.serialize(object.detail,
                    specifiedType: const FullType(String)));
        }
        if (object.instance != null) {
            result
                ..add(r'instance')
                ..add(serializers.serialize(object.instance,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    ProblemDetails deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = ProblemDetailsBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            switch (key) {
                case r'type':
                    result.type = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'title':
                    result.title = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'status':
                    result.status = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    break;
                case r'detail':
                    result.detail = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
                case r'instance':
                    result.instance = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    break;
            }
        }
        return result.build();
    }
}


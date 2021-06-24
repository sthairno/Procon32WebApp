//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:openapi/src/date_serializer.dart';
import 'package:openapi/src/model/date.dart';

import 'package:openapi/src/model/api_key.dart';
import 'package:openapi/src/model/count_xy.dart';
import 'package:openapi/src/model/image.dart';
import 'package:openapi/src/model/peace_rotate.dart';
import 'package:openapi/src/model/problem_details.dart';
import 'package:openapi/src/model/size.dart';
import 'package:openapi/src/model/subject.dart';
import 'package:openapi/src/model/user.dart';

part 'serializers.g.dart';

@SerializersFor([
  APIKey,
  CountXY,
  Image,
  PeaceRotate,
  ProblemDetails,
  Size,
  Subject,
  User,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Image)]),
        () => ListBuilder<Image>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Subject)]),
        () => ListBuilder<Subject>(),
      )
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

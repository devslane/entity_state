import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:example/models/user.dart';
import 'package:example/serializers/types.dart';

part 'serializers.g.dart';

@SerializersFor([User])
final Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(userBuiltList, () => ListBuilder<User>())
      ..addPlugin(StandardJsonPlugin()))
    .build();

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:example/models/user.dart';

// To deserialize a list of user objects use serializers.deserialize(data, specifiedType: userList);
const userBuiltList = FullType(BuiltList, [FullType(User)]);

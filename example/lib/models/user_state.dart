import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:entity_state/entity_state.dart';
import 'package:example/models/user.dart';

part 'user_state.g.dart';

abstract class UserState
    with EntityState<User, String, UserState, UserStateBuilder>
    implements Built<UserState, UserStateBuilder> {
  BuiltList<String> get ids;

  BuiltMap<String, User> get entities;

  bool get isLoading;

  BuiltMap<String, bool> get deletingIds;

  BuiltMap<String, bool> get updatingIds;

  static Serializer<UserState> get serializer => _$userStateSerializer;

  factory UserState() => _$UserState((b) => b
    ..isLoading = false
    ..deletingIds = BuiltMap<String, bool>().toBuilder()
    ..updatingIds = BuiltMap<String, bool>().toBuilder());

  UserState._();

  @override
  String getId(User data) => data.id;
}

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  static Serializer<User> get serializer => _$userSerializer;

  String get id;

  @BuiltValueField(wireName: "first_name")
  String get firstName;

  @nullable
  @BuiltValueField(wireName: "last_name")
  String get lastName;

  @memoized
  String get fullName {
    return firstName + (lastName != null ? (" " + lastName) : "");
  }

  User._();

  factory User([updates(UserBuilder b)]) = _$User;
}

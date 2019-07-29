import 'package:example/models/user.dart';

class ListUsers {}

class ListUsersComplete {
  final List<User> users;

  ListUsersComplete(this.users);
}

class AddOneUser{
  final User user;
  AddOneUser(this.user);
}

class UpdateUser {
  final User user;

  UpdateUser(this.user);
}

class UpdateUserComplete {
  final User user;

  UpdateUserComplete(this.user);
}

class UpdateManyUser{
  final List<User> users;
  UpdateManyUser(this.users);
}

class DeleteUser {
  final String userId;

  DeleteUser(this.userId);
}

class DeleteUserComplete {
  final String userId;

  DeleteUserComplete(this.userId);
}

class DeleteManyUser{
  final List<String> users;
  DeleteManyUser(this.users);
}

class DeleteAllUsers {}

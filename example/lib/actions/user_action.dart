import 'package:example/models/user.dart';

class ListUsers {}

class ListUsersComplete {
  final List<User> users;

  ListUsersComplete(this.users);
}

class UpdateUser {
  final User user;

  UpdateUser(this.user);
}

class UpdateUserComplete {
  final User user;

  UpdateUserComplete(this.user);
}

class DeleteUser {
  final String userId;

  DeleteUser(this.userId);
}

class DeleteUserComplete {
  final String userId;

  DeleteUserComplete(this.userId);
}

import 'package:example/actions/user_action.dart';
import 'package:example/models/user_state.dart';
import 'package:redux/redux.dart';

Reducer<UserState> userReducer = combineReducers([
  TypedReducer<UserState, ListUsers>(list),
  TypedReducer<UserState, AddOneUser>(addOneUser),
  TypedReducer<UserState, ListUsersComplete>(listComplete),
  TypedReducer<UserState, UpdateUser>(update),
  TypedReducer<UserState, UpdateUserComplete>(updateComplete),
  TypedReducer<UserState, UpdateManyUser>(updateMany),
  TypedReducer<UserState, DeleteUser>(delete),
  TypedReducer<UserState, DeleteUserComplete>(deleteComplete),
  TypedReducer<UserState, DeleteAllUsers>(deleteAll),
  TypedReducer<UserState, DeleteManyUser>(deleteManyUser),
]);

UserState list(UserState state, ListUsers action) {
  return state.rebuild((b) => b..isLoading = true);
}

UserState listComplete(UserState state, ListUsersComplete action) {
  return state.addMany(action.users).rebuild((b) => b..isLoading = false);
}

UserState update(UserState state, UpdateUser action) {
  return state.rebuild((b) => b
    ..updatingIds = state.updatingIds
        .rebuild((b) => b..addAll({action.user.id: true}))
        .toBuilder());
}

UserState updateComplete(UserState state, UpdateUserComplete action) {
  return state.updateOne(action.user).rebuild((b) => b
    ..updatingIds = state.updatingIds
        .rebuild((b) => b..addAll({action.user.id: false}))
        .toBuilder());
}

UserState delete(UserState state, DeleteUser action) {
  return state.rebuild((b) => b
    ..deletingIds = state.deletingIds
        .rebuild((b) => b..addAll({action.userId: true}))
        .toBuilder());
}

UserState deleteComplete(UserState state, DeleteUserComplete action) {
  return state.removeOne(action.userId).rebuild((b) => b
    ..deletingIds = state.deletingIds
        .rebuild((b) => b..addAll({action.userId: false}))
        .toBuilder());
}

UserState deleteAll(UserState state, DeleteAllUsers action) {
  return state.removeAll();
}

UserState deleteManyUser(UserState state, DeleteManyUser action) {
  return state.removeMany(action.users);
}

UserState addOneUser(UserState state, AddOneUser action) {
  return state.addOne(action.user);
}

UserState updateMany(UserState state, UpdateManyUser action) {
  return state.updateMany(action.users);
}

import 'package:example/actions/user_action.dart';
import 'package:example/models/user_state.dart';
import 'package:redux/redux.dart';

Reducer<UserState> userReducer = combineReducers([
  TypedReducer<UserState, ListUsers>(list),
  TypedReducer<UserState, ListUsersComplete>(listComplete),
  TypedReducer<UserState, UpdateUser>(update),
  TypedReducer<UserState, UpdateUserComplete>(updateComplete),
  TypedReducer<UserState, DeleteUser>(delete),
  TypedReducer<UserState, DeleteUserComplete>(deleteComplete),
]);

UserState list(UserState state, ListUsers action) {
  return state.rebuild((b) => b..isLoading = true);
}

UserState listComplete(UserState state, ListUsersComplete action) {
  return state.addAll(action.users).rebuild((b) => b..isLoading = false);
}

UserState update(UserState state, UpdateUser action) {
  return state.rebuild((b) => b..isUpdating = true);
}

UserState updateComplete(UserState state, UpdateUserComplete action) {
  return state.updateOne(action.user).rebuild((b) => b..isUpdating = false);
}

UserState delete(UserState state, DeleteUser action) {
  return state.rebuild((b) => b..isUpdating = true);
}

UserState deleteComplete(UserState state, DeleteUserComplete action) {
  return state.removeOne(action.userId).rebuild((b) => b..isUpdating = false);
}

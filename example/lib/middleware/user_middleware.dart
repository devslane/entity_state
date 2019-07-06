import 'package:example/actions/user_action.dart';
import 'package:example/models/user_state.dart';
import 'package:example/user_service.dart';
import 'package:redux/redux.dart';

Future<Null> userMiddleware(
    Store<UserState> store, action, NextDispatcher next) async {
  switch (action.runtimeType) {
    case ListUsers:
      {
        next(action);

        store.dispatch(
            ListUsersComplete(await UserService.getInstance().list()));

        break;
      }
    default:
      next(action);
  }
}

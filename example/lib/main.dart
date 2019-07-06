import 'package:example/actions/user_action.dart';
import 'package:example/middleware/user_middleware.dart';
import 'package:example/models/user.dart';
import 'package:example/models/user_state.dart';
import 'package:example/reducers/user_reducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = Store<UserState>(userReducer,
      initialState: UserState(), middleware: [userMiddleware]);

  MyApp() {
    store.dispatch(ListUsers());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Entity State',
        home: HomePageContainer(),
      ),
    );
    ;
  }
}

class HomePageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<UserState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel model) => MyHomePage(
            isLoading: model.isLoading,
            users: model.users,
          ),
    );
  }
}

class _ViewModel {
  final bool isLoading;
  final List<User> users;

  _ViewModel({@required this.isLoading, @required this.users});

  static _ViewModel fromStore(Store<UserState> store) {
    return _ViewModel(
        isLoading: store.state.isLoading, users: store.state.getAll());
  }
}

class MyHomePage extends StatelessWidget {
  final bool isLoading;
  final List<User> users;

  MyHomePage({@required this.isLoading, @required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entity State"),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(users.elementAt(index).fullName),
                          FlatButton(
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              //
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}

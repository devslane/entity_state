import 'package:example/actions/user_action.dart';
import 'package:example/middleware/user_middleware.dart';
import 'package:example/models/user.dart';
import 'package:example/models/user_state.dart';
import 'package:example/reducers/user_reducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:random_string/random_string.dart';
import 'package:redux/redux.dart';

typedef OnDelete = void Function(String userId);
typedef OnUpdate = void Function(User user);

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
        deletingIds: model.deletingIds,
        onDelete: model.onDelete,
        onDeleteAll: model.onDeleteAll,
        onDeleteMany: model.onDeleteMany,
        entities: model.entities,
        addOne: model.addOne,
        ids: model.ids,
        updateOne: model.updateOne,
        updateMany: model.updateMany,
      ),
    );
  }
}

class _ViewModel {
  final bool isLoading;
  final List<User> users;
  final Map<String, bool> deletingIds;

  final OnDelete onDelete;
  final Function onDeleteMany;

  final Function onDeleteAll;

  final Function addOne;
  final Function updateOne;
  final Function updateMany;
  final Map<String, User> entities;
  final List<String> ids;

  _ViewModel(
      {@required this.entities,
      @required this.ids,
      @required this.addOne,
      @required this.updateOne,
      @required this.updateMany,
      @required this.isLoading,
      @required this.users,
      @required this.onDelete,
      @required this.onDeleteMany,
      @required this.deletingIds,
      @required this.onDeleteAll});

  static _ViewModel fromStore(Store<UserState> store) {
    return _ViewModel(
      ids: store.state.getIds(),
      addOne: (user) => store.dispatch(AddOneUser(user)),
      updateOne: (user) => store.dispatch(UpdateUser(user)),
      updateMany: (users) => store.dispatch(UpdateManyUser(users)),
      entities: store.state.getEntities(),
      isLoading: store.state.isLoading,
      users: store.state.getAll((a, b) => a.fullName.compareTo(b.fullName)),
      onDelete: (String userId) => store.dispatch(DeleteUser(userId)),
      onDeleteMany: (usersIds) => store.dispatch(DeleteManyUser(usersIds)),
      deletingIds: store.state.deletingIds.toMap(),
      onDeleteAll: () {
        store.dispatch(DeleteAllUsers());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool isLoading;
  final List<User> users;
  final Map<String, bool> deletingIds;

  final OnDelete onDelete;
  final Function onDeleteAll;
  final Function onDeleteMany;

  final Function addOne;
  final Function updateOne;
  final Function updateMany;

  final Map<String, User> entities;
  final List<String> ids;

  MyHomePage(
      {@required this.entities,
      @required this.ids,
      @required this.addOne,
      @required this.updateMany,
      @required this.updateOne,
      @required this.isLoading,
      @required this.users,
      @required this.onDelete,
      @required this.onDeleteMany,
      @required this.deletingIds,
      @required this.onDeleteAll});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textFieldController = TextEditingController();
  bool val = false;
  Map<String, User> selectedValues = new Map();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addOneDialog(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Entity State"),
        actions: <Widget>[
          (selectedValues.length > 0)
              ? Row(
                  children: <Widget>[
                    FlatButton(
                      child: Text("Update Selected"),
                      onPressed: () {
                        _updateManyDialog(
                            context, selectedValues.keys.toList());
                      },
                    ),
                    FlatButton(
                      child: Text("Delete Selected"),
                      onPressed: () {
                        widget.onDeleteMany(selectedValues.keys.toList());
                        setState(() {
                          selectedValues = new Map();
                        });
                      },
                    )
                  ],
                )
              : FlatButton(
                  child: Text("Delete All"),
                  onPressed: () {
                    widget.onDeleteAll();
                  },
                )
        ],
      ),
      body: Center(
        child: widget.isLoading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: widget.users.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = widget.users.elementAt(index);
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Checkbox(
                            value: (selectedValues.containsKey(user.id))
                                ? true
                                : false,
                            onChanged: (bool value) {
                              setState(() {
                                if (selectedValues.containsKey(user.id))
                                  selectedValues.remove(user.id);
                                else
                                  selectedValues.addAll({user.id: user});
                              });
                            },
                          ),
                          Expanded(child: Text(user.fullName)),
                          FlatButton(
                            child: Icon(Icons.edit),
                            onPressed: () => _updateOneDialog(context, user),
                          ),
                          FlatButton(
                            child: (widget.deletingIds[user.id] != null &&
                                    widget.deletingIds[user.id])
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.red),
                                  )
                                : Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                            onPressed: () {
                              widget.onDelete(user.id);
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

  _addOneDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Your Name'),
            content: TextField(
              controller: _textFieldController,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('SAVE'),
                onPressed: () {
                  User user = new User((b) => b
                    ..id = randomAlphaNumeric(20)
                    ..firstName = _textFieldController.text);
                  widget.addOne(user);
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _updateOneDialog(BuildContext context, User user) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Your Name'),
            content: TextField(
              decoration: InputDecoration(hintText: user.fullName),
              controller: _textFieldController,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('UPDATE'),
                onPressed: () {
                  user=user.rebuild((b) => b..firstName = _textFieldController.text);
                  widget.updateOne(user);
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _updateManyDialog(BuildContext context, List<String> idsList) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Your Name'),
            content: TextField(
              controller: _textFieldController,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('UPDATE'),
                onPressed: () {
                  List<User> updatedUsers = new List();
                  idsList.forEach((id) {
                    updatedUsers
                      ..add(selectedValues[id].rebuild(
                          (b) => b..firstName = _textFieldController.text));
                  });
                  setState(() {
                    selectedValues = new Map();
                  });
                  widget.updateMany(updatedUsers);
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    selectedValues = new Map();
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}

library entity_state;

import 'package:built_collection/built_collection.dart';
import 'package:entity_state/errors/method_not_overriden.dart';

/// Use this class with any of the redux state.
///
/// Generics:
/// T -> The type of the value i.e the type of value in the map [entities].
/// V -> The type of the identifier, should be either [int] or [String]. This is usually the identifier of the object that you get from your backend.
/// K -> The type of the state i.e the class of the state. eg. NotificationsState.
/// B -> The builder of the class. eg. NotificationsStateBuilder.
///
/// Usage:
///
/// ```
/// abstract class AppNotificationState
///    with
///        EntityState<AppNotification, int, AppNotificationState,
///            AppNotificationBuilder>
///    implements
///        Built<AppNotificationState, AppNotificationStateBuilder> {
///  bool get isLoading;
///
///  BuiltList<int> get ids;
///
///  BuiltMap<int, AppNotification> get entities;
///
///  static Serializer<AppNotificationState> get serializer =>
///      _$appNotificationStateSerializer;
///
///  factory AppNotificationState() {
///    return _$AppNotificationState((b) => b
///      ..isLoading = false
///      ..ids = BuiltList<int>().toBuilder()
///      ..entities = MapBuilder<int, AppNotification>());
///  }
///
///  AppNotificationState._();
///
///  @override
///  int getId(AppNotification data) {
///    return data.id;
///  }
///}
///```

mixin EntityState<T, V, K, B> {
  /// A list that keeps all the ids of the values in the state.
  ///
  /// The value is obtained by [getId] method.
  BuiltList<V> get ids;

  /// A Map that keeps all the values in the state.
  ///
  /// The key of the map is the value returned by [getId] method.
  BuiltMap<V, T> get entities;

  K rebuild(updates(B));

  /// This method must be overridden in the class without the call of super();
  ///
  ///  Throws [MethodGetIdNotOverriddenError] exception if the method is called with super or is not overridden.
  ///
  /// The method returns the unique identifier of the entity that will be make up the key in the `entities` map.
  V getId(T data) {
    throw MethodGetIdNotOverriddenError();
  }

  // Setter Methods

  /// Added a single entity in the state.
  ///
  /// Returns the newly object of the state using rebuild.
  K addOne(T data) {
    return rebuild((b) => b
      ..ids = BuiltList<V>.from(ids.toList()..add(getId(data))).toBuilder()
      ..entities =
          BuiltMap<V, T>.from(entities.toMap()..addAll({getId(data): data}))
              .toBuilder());
  }

  /// This replaces all the previous values of state with the new ones in [data].
  ///
  /// Usage
  ///
  /// ```
  /// AppNotificationState listNotificationComplete(
  ///    AppNotificationState appNotificationState,
  ///    ListNotificationComplete action) {
  ///  return appNotificationState
  ///      .addAll(action.notifications);
  ///}
  ///```
  K addAll(List<T> data) {
    return rebuild((b) => b
      ..ids = _getBuiltList(data)
      ..entities = _getMapBuilder(data));
  }

  /// This appends the [data] to the already present [entities] and [ids] in the state.
  ///
  /// Usage
  ///
  /// ```
  /// AppNotificationState listNotificationNextPageComplete(
  ///    AppNotificationState appNotificationState,
  ///    ListNotificationNextPageComplete action) {
  ///  return appNotificationState
  ///      .addMany(action.notifications);
  ///}
  ///```
  K addMany(List<T> data) {
    return rebuild((b) => b
      ..ids = (ids.toBuilder()..addAll(data.map((item) => getId(item))))
      ..entities = entities.toBuilder()
      ..addIterable(data, key: (item) => getId(item), value: (item) => item));
  }

  /// This is used to update one of the values already present in the [entities].
  ///
  /// It ignores if the values is not already present in the state.
  ///
  /// Usage
  ///
  /// ```
  /// AppNotificationState updateNotificationComplete(
  ///    AppNotificationState appNotificationState,
  ///    UpdateNotificationComplete action) {
  ///  return appNotificationState
  ///      .updateOne(action.notification);
  ///}
  ///```
  K updateOne(T data) {
    return rebuild((b) => b
      ..entities =
          BuiltMap<V, T>.from(entities.toMap()..addAll({getId(data): data}))
              .toBuilder());
  }

  /// This updates all the values in [data] on [entities] that are present.
  ///
  /// It ignores the values in [data] that are not present in [entities].
  ///
  /// Usage
  ///
  /// ```
  /// AppNotificationState updateNotificationsComplete(
  ///    AppNotificationState appNotificationState,
  ///    UpdateNotificationsComplete action) {
  ///  return appNotificationState
  ///      .updateMany(action.notifications);
  ///}
  ///```
  K updateMany(List<T> data) {
    return rebuild((b) => b
      ..entities = BuiltMap<V, T>.from(entities.toMap()
            ..updateAll((key, value) =>
                data.map((d) => getId(d)).contains((d) => key)
                    ? data.firstWhere((d) => getId(d) == key)
                    : value))
          .toBuilder());
  }

  /// This removes a single value in [entities] and [ids].
  ///
  /// If the [data] is not already present in [entities] and [ids] it just ignores.
  ///
  /// Usage
  ///
  /// ```
  /// AppNotificationState deleteNotificationComplete(
  ///    AppNotificationState appNotificationState,
  ///    DeleteNotificationComplete action) {
  ///  return appNotificationState
  ///      .removeOne(action.notification);
  ///}
  ///```
  K removeOne(V data) {
    return rebuild((b) => b
      ..ids =
          BuiltList<V>.from(ids.toList()..removeWhere((elem) => elem == data))
              .toBuilder()
      ..entities = BuiltMap<V, T>.from(
              entities.toMap()..removeWhere((V key, T value) => key == data))
          .toBuilder());
  }

  /// This is used to bulk removal of values from [entities] and [ids].
  ///
  /// It ignores the values in [data] that are not present in [entities] and [ids].
  ///
  /// Usage
  ///
  /// ```
  /// AppNotificationState removeNotificationsComplete(
  ///    AppNotificationState appNotificationState,
  ///    RemoveNotificationsComplete action) {
  ///  return appNotificationState
  ///      .removeMany(action.notifications);
  ///}
  ///```
  K removeMany(List<V> data) {
    return rebuild((b) => b
      ..ids = BuiltList<V>.from(
              ids.toList()..removeWhere((elem) => data.contains(elem)))
          .toBuilder()
      ..entities = BuiltMap<V, T>.from(entities.toMap()
            ..removeWhere((V key, T value) => data.contains(key)))
          .toBuilder());
  }

  /// Empties the whole state.
  ///
  /// Usage
  ///
  /// ```
  /// AppNotificationState reset(
  ///    AppNotificationState appNotificationState,
  ///    Reset action) {
  ///  return appNotificationState
  ///      .removeAll(action.notifications);
  ///}
  ///```
  K removeAll() {
    return rebuild((b) => b
      ..ids = []
      ..entities = {});
  }

  /// Getter Methods. These methods are useful when getting values from the state.

  /// Get all the ids of the [entities] as a List.
  ///
  /// Usage
  ///
  /// ```
  /// static _ViewModel fromStore(Store<AppState> store) {
  ///    return _ViewModel(
  ///       notificationIds: store.state.appNotification.getIds());
  ///  }
  ///```
  List<V> getIds() {
    return ids.toList();
  }

  /// Get all the values in the state as a Map.
  ///
  /// Usage
  ///
  /// ```
  /// static _ViewModel fromStore(Store<AppState> store) {
  ///    return _ViewModel(
  ///       notificationEntities: store.state.appNotification.getEntities());
  ///  }
  ///```
  Map<V, T> getEntities() {
    return entities.toMap();
  }

  /// Get all the values in the state as List.
  ///
  /// Usage
  ///
  /// ```
  /// static _ViewModel fromStore(Store<AppState> store) {
  ///    return _ViewModel(
  ///       notifications: store.state.appNotification.getAll());
  ///  }
  ///```
  List<T> getAll() {
    return entities.values.toList();
  }

  /// Get the total count of [entities] in the state.
  ///
  /// Usage
  ///
  /// ```
  /// static _ViewModel fromStore(Store<AppState> store) {
  ///    return _ViewModel(
  ///       notificationsCount: store.state.appNotification.getCount());
  ///  }
  ///```
  int getCount() {
    return ids.length;
  }

  /// Internal Helper Methods

  ListBuilder<V> _getBuiltList(List<T> list) {
    return BuiltList<V>.from(list.map((item) => getId(item))).toBuilder();
  }

  MapBuilder<V, T> _getMapBuilder(List<T> list) {
    return BuiltMap<V, T>.from(Map.fromIterable(list,
        key: (item) => getId(item), value: (item) => item)).toBuilder();
  }
}

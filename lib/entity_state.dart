library entity_state;

import 'package:built_collection/built_collection.dart';
import 'package:entity_state/errors/method_not_overriden.dart';

mixin EntityState<T, V, K, B> {
  BuiltList<V> get ids;

  BuiltMap<V, T> get entities;

  K rebuild(updates(B));

  V getId(T data) {
    throw MethodGetIdNotOverridenError();
  }

  // Setter Methods

  K addOne(T data) {
    return rebuild((b) => b
      ..ids = ids.toBuilder()
      ..add(getId(data))
      ..entities = entities.toBuilder()
      ..addAll(Map<V, T>.from({getId(data): data})));
  }

  K addAll(List<T> data) {
    return rebuild((b) => b
      ..ids = _getBuiltList(data)
      ..entities = _getMapBuilder(data));
  }

  K addMany(List<T> data) {
    return rebuild((b) => b
      ..ids = (ids.toBuilder()..addAll(data.map((item) => getId(item))))
      ..entities = entities.toBuilder()
      ..addIterable(data, key: (item) => getId(item), value: (item) => item));
  }

  K updateOne(T data) {
    return rebuild((b) => b
      ..entities =
          BuiltMap<V, T>.from(entities.toMap()..addAll({getId(data): data}))
              .toBuilder());
  }

  K updateMany(List<T> data) {
    return rebuild((b) => b
      ..entities = entities.toBuilder()
      ..addIterable(data, key: (item) => getId(item), value: (item) => item));
  }

  K removeOne(V data) {
    return rebuild((b) => b
      ..ids = ids.toBuilder()
      ..removeWhere((id) => id == data)
      ..entities = entities.toBuilder()
      ..removeWhere((V key, T value) => key == data));
  }

  K removeMany(List<V> data) {
    return rebuild((b) => b
      ..ids = ids.toBuilder()
      ..removeWhere((id) => data.indexOf(id) > -1)
      ..entities = entities.toBuilder()
      ..removeWhere((V key, T value) => data.indexOf(key) > -1));
  }

  K removeAll() {
    return rebuild((b) => b
      ..ids = []
      ..entities = {});
  }

  // Getter Methods

  List<V> getIds() {
    return ids.toList();
  }

  Map<V, T> getEntities() {
    return entities.toMap();
  }

  List<T> getAll() {
    return entities.values.toList();
  }

  int getCount() {
    return ids.length;
  }

  // Helper Methods

  ListBuilder<V> _getBuiltList(Iterable<T> list) {
    return BuiltList<V>.from(list.map((item) => getId(item))).toBuilder();
  }

  MapBuilder<V, T> _getMapBuilder(List<T> list) {
    return BuiltMap<V, T>.from(Map.fromIterable(list,
        key: (item) => getId(item), value: (item) => item)).toBuilder();
  }
}

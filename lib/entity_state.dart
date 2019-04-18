library entity_state;

import 'package:built_collection/built_collection.dart';
import 'package:entity_state/errors/method_not_overriden.dart';

mixin EntityState<T, V, K, B> {
  BuiltList<V> get ids;

  BuiltMap<V, T> get entities;

  K rebuild(updates(B));

  V getId(T data) {
    throw MethodNotOverridenError();
  }

  // Setter Methods

  K addOne(T data) {
    return rebuild((b) => b
      ..ids = (ids.toBuilder()..add(getId(data))).build()
      ..entities = (entities.toBuilder()
            ..addAll(Map<V, T>.from({getId(data): data})))
          .build());
  }

  K addAll(List<T> data) {
    return rebuild((b) => b
      ..ids = _getBuiltList(data).build()
      ..entities = _getMapBuilder(data).build());
  }

  K addMany(List<T> data) {
    return rebuild((b) => b
      ..ids = (ids.toBuilder()..addAll(data.map((item) => getId(item)))).build()
      ..entities = (entities.toBuilder()
            ..addIterable(data,
                key: (item) => getId(item), value: (item) => item))
          .build());
  }

  K updateOne(T data) {
    return rebuild((b) => b
      ..entities = (entities.toBuilder()
            ..updateValue(getId(data), (data) => data))
          .build());
  }

  K updateMany(List<T> data) {
    return rebuild((b) => b
      ..entities = (entities.toBuilder()
            ..addIterable(data,
                key: (item) => getId(item), value: (item) => item))
          .build());
  }

  K removeOne(V data) {
    return rebuild((b) => b
      ..ids = (ids.toBuilder()..removeWhere((id) => id == data)).build()
      ..entities = (entities.toBuilder()
            ..removeWhere((V key, T value) => key == data))
          .build());
  }

  K removeMany(List<V> data) {
    return rebuild((b) => b
      ..ids =
          (ids.toBuilder()..removeWhere((id) => data.indexOf(id) > -1)).build()
      ..entities = (entities.toBuilder()
            ..removeWhere((V key, T value) => data.indexOf(key) > -1))
          .build());
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

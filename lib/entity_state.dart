library entity_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:entity_state/errors/method_not_overriden.dart';

part 'entity_state.g.dart';

abstract class EntityState<T, V, K, A>
    implements Built<EntityState<T, V, K, A>, EntityStateBuilder<T, V, K, A>> {
  BuiltList<V> get ids;

  BuiltMap<V, T> get entities;

  EntityState._();

  factory EntityState([void Function(EntityStateBuilder<T, V, K, A>) updates]) =
      _$EntityState<T, V, K, A>;

  static Serializer<EntityState> get serializer => _$entityStateSerializer;

  V getId() {
    throw MethodNotOverridenError();
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
}

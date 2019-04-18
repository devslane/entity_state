// GENERATED CODE - DO NOT MODIFY BY HAND

part of entity_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EntityState> _$entityStateSerializer = new _$EntityStateSerializer();

class _$EntityStateSerializer implements StructuredSerializer<EntityState> {
  @override
  final Iterable<Type> types = const [EntityState, _$EntityState];
  @override
  final String wireName = 'EntityState';

  @override
  Iterable serialize(Serializers serializers, EntityState object,
      {FullType specifiedType = FullType.unspecified}) {
    final isUnderspecified =
        specifiedType.isUnspecified || specifiedType.parameters.isEmpty;
    if (!isUnderspecified) serializers.expectBuilder(specifiedType);
    final parameterT =
        isUnderspecified ? FullType.object : specifiedType.parameters[0];
    final parameterV =
        isUnderspecified ? FullType.object : specifiedType.parameters[1];

    final result = <Object>[
      'ids',
      serializers.serialize(object.ids,
          specifiedType: new FullType(BuiltList, [parameterV])),
      'entities',
      serializers.serialize(object.entities,
          specifiedType: new FullType(BuiltMap, [parameterV, parameterT])),
    ];

    return result;
  }

  @override
  EntityState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final isUnderspecified =
        specifiedType.isUnspecified || specifiedType.parameters.isEmpty;
    if (!isUnderspecified) serializers.expectBuilder(specifiedType);
    final parameterT =
        isUnderspecified ? FullType.object : specifiedType.parameters[0];
    final parameterV =
        isUnderspecified ? FullType.object : specifiedType.parameters[1];

    final result = isUnderspecified
        ? new EntityStateBuilder<Object, Object, Object, Object>()
        : serializers.newBuilder(specifiedType) as EntityStateBuilder;

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'ids':
          result.ids.replace(serializers.deserialize(value,
                  specifiedType: new FullType(BuiltList, [parameterV]))
              as BuiltList);
          break;
        case 'entities':
          result.entities.replace(serializers.deserialize(value,
                  specifiedType:
                      new FullType(BuiltMap, [parameterV, parameterT]))
              as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$EntityState<T, V, K, A> extends EntityState<T, V, K, A> {
  @override
  final BuiltList<V> ids;
  @override
  final BuiltMap<V, T> entities;

  factory _$EntityState(
          [void Function(EntityStateBuilder<T, V, K, A>) updates]) =>
      (new EntityStateBuilder<T, V, K, A>()..update(updates)).build();

  _$EntityState._({this.ids, this.entities}) : super._() {
    if (ids == null) {
      throw new BuiltValueNullFieldError('EntityState', 'ids');
    }
    if (entities == null) {
      throw new BuiltValueNullFieldError('EntityState', 'entities');
    }
    if (T == dynamic) {
      throw new BuiltValueMissingGenericsError('EntityState', 'T');
    }
    if (V == dynamic) {
      throw new BuiltValueMissingGenericsError('EntityState', 'V');
    }
    if (K == dynamic) {
      throw new BuiltValueMissingGenericsError('EntityState', 'K');
    }
    if (A == dynamic) {
      throw new BuiltValueMissingGenericsError('EntityState', 'A');
    }
  }

  @override
  EntityState<T, V, K, A> rebuild(
          void Function(EntityStateBuilder<T, V, K, A>) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EntityStateBuilder<T, V, K, A> toBuilder() =>
      new EntityStateBuilder<T, V, K, A>()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EntityState &&
        ids == other.ids &&
        entities == other.entities;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, ids.hashCode), entities.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('EntityState')
          ..add('ids', ids)
          ..add('entities', entities))
        .toString();
  }
}

class EntityStateBuilder<T, V, K, A>
    implements
        Builder<EntityState<T, V, K, A>, EntityStateBuilder<T, V, K, A>> {
  _$EntityState<T, V, K, A> _$v;

  ListBuilder<V> _ids;
  ListBuilder<V> get ids => _$this._ids ??= new ListBuilder<V>();
  set ids(ListBuilder<V> ids) => _$this._ids = ids;

  MapBuilder<V, T> _entities;
  MapBuilder<V, T> get entities => _$this._entities ??= new MapBuilder<V, T>();
  set entities(MapBuilder<V, T> entities) => _$this._entities = entities;

  EntityStateBuilder();

  EntityStateBuilder<T, V, K, A> get _$this {
    if (_$v != null) {
      _ids = _$v.ids?.toBuilder();
      _entities = _$v.entities?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EntityState<T, V, K, A> other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$EntityState<T, V, K, A>;
  }

  @override
  void update(void Function(EntityStateBuilder<T, V, K, A>) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$EntityState<T, V, K, A> build() {
    _$EntityState<T, V, K, A> _$result;
    try {
      _$result = _$v ??
          new _$EntityState<T, V, K, A>._(
              ids: ids.build(), entities: entities.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'ids';
        ids.build();
        _$failedField = 'entities';
        entities.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'EntityState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

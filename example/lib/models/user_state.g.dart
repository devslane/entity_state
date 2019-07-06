// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserState> _$userStateSerializer = new _$UserStateSerializer();

class _$UserStateSerializer implements StructuredSerializer<UserState> {
  @override
  final Iterable<Type> types = const [UserState, _$UserState];
  @override
  final String wireName = 'UserState';

  @override
  Iterable serialize(Serializers serializers, UserState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'ids',
      serializers.serialize(object.ids,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'entities',
      serializers.serialize(object.entities,
          specifiedType: const FullType(
              BuiltMap, const [const FullType(String), const FullType(User)])),
      'isLoading',
      serializers.serialize(object.isLoading,
          specifiedType: const FullType(bool)),
      'isUpdating',
      serializers.serialize(object.isUpdating,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  UserState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'ids':
          result.ids.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
        case 'entities':
          result.entities.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(User)
              ])) as BuiltMap);
          break;
        case 'isLoading':
          result.isLoading = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isUpdating':
          result.isUpdating = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$UserState extends UserState {
  @override
  final BuiltList<String> ids;
  @override
  final BuiltMap<String, User> entities;
  @override
  final bool isLoading;
  @override
  final bool isUpdating;

  factory _$UserState([void Function(UserStateBuilder) updates]) =>
      (new UserStateBuilder()..update(updates)).build();

  _$UserState._({this.ids, this.entities, this.isLoading, this.isUpdating})
      : super._() {
    if (ids == null) {
      throw new BuiltValueNullFieldError('UserState', 'ids');
    }
    if (entities == null) {
      throw new BuiltValueNullFieldError('UserState', 'entities');
    }
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('UserState', 'isLoading');
    }
    if (isUpdating == null) {
      throw new BuiltValueNullFieldError('UserState', 'isUpdating');
    }
  }

  @override
  UserState rebuild(void Function(UserStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserStateBuilder toBuilder() => new UserStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserState &&
        ids == other.ids &&
        entities == other.entities &&
        isLoading == other.isLoading &&
        isUpdating == other.isUpdating;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, ids.hashCode), entities.hashCode), isLoading.hashCode),
        isUpdating.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserState')
          ..add('ids', ids)
          ..add('entities', entities)
          ..add('isLoading', isLoading)
          ..add('isUpdating', isUpdating))
        .toString();
  }
}

class UserStateBuilder implements Builder<UserState, UserStateBuilder> {
  _$UserState _$v;

  ListBuilder<String> _ids;
  ListBuilder<String> get ids => _$this._ids ??= new ListBuilder<String>();
  set ids(ListBuilder<String> ids) => _$this._ids = ids;

  MapBuilder<String, User> _entities;
  MapBuilder<String, User> get entities =>
      _$this._entities ??= new MapBuilder<String, User>();
  set entities(MapBuilder<String, User> entities) =>
      _$this._entities = entities;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  bool _isUpdating;
  bool get isUpdating => _$this._isUpdating;
  set isUpdating(bool isUpdating) => _$this._isUpdating = isUpdating;

  UserStateBuilder();

  UserStateBuilder get _$this {
    if (_$v != null) {
      _ids = _$v.ids?.toBuilder();
      _entities = _$v.entities?.toBuilder();
      _isLoading = _$v.isLoading;
      _isUpdating = _$v.isUpdating;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserState;
  }

  @override
  void update(void Function(UserStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserState build() {
    _$UserState _$result;
    try {
      _$result = _$v ??
          new _$UserState._(
              ids: ids.build(),
              entities: entities.build(),
              isLoading: isLoading,
              isUpdating: isUpdating);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'ids';
        ids.build();
        _$failedField = 'entities';
        entities.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:example/models/user.dart';
import 'package:example/serializers/serializers.dart';
import 'package:example/serializers/types.dart';

class UserService {
  final rawData = [
    {
      "id": "5d20ecfc59cb1c0f2c386cee",
      "first_name": "Mclean",
      "last_name": "Velazquez"
    },
    {
      "id": "5d20ecfccbdf7fb08c86c798",
      "first_name": "Terri",
      "last_name": "Padilla"
    },
    {
      "id": "5d20ecfcd435256672973f26",
      "first_name": "Sherrie",
      "last_name": "Gallagher"
    },
    {
      "id": "5d20ecfcc891697fe955876d",
      "first_name": "Robles",
      "last_name": "Holloway"
    },
    {
      "id": "5d20ecfcb1d148c71039ca34",
      "first_name": "Morgan",
      "last_name": "Travis"
    },
    {
      "id": "5d20ecfc3b2c54dc96cc0732",
      "first_name": "Amber",
      "last_name": "Haynes"
    },
    {
      "id": "5d20ecfcb3157a31212c37f8",
      "first_name": "Janelle",
      "last_name": "Hahn"
    },
    {
      "id": "5d20ecfcd802e69bdbcf3e46",
      "first_name": "Penelope",
      "last_name": "Miles"
    },
    {
      "id": "5d20ecfc1f169fb56610e01c",
      "first_name": "Mcknight",
      "last_name": "Gray"
    },
    {
      "id": "5d20ecfcd37b37da4dd139b0",
      "first_name": "Earline",
      "last_name": "Mclean"
    },
    {
      "id": "5d20ecfc08b84cb2299cdf63",
      "first_name": "Decker",
      "last_name": "Cardenas"
    },
    {
      "id": "5d20ecfc71545b7cc49f9bed",
      "first_name": "Michele",
      "last_name": "Wilder"
    },
    {
      "id": "5d20ecfcd00c69019857b79a",
      "first_name": "Mattie",
      "last_name": "Workman"
    },
    {
      "id": "5d20ecfc9506ded53b7cc42d",
      "first_name": "Garner",
      "last_name": "Silva"
    }
  ];

  UserService._();

  static UserService _instance = UserService._();

  factory UserService.getInstance() => _instance;

  Future<List<User>> list() {
    return Future<List<User>>.delayed(Duration(milliseconds: 1500), () {
      return (serializers.deserialize(rawData, specifiedType: userBuiltList)
              as BuiltList<User>)
          .toList();
    });
  }
}

import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/data/models/user_model.dart';

@LazySingleton()
class Prefs {
  final SharedPreferences _prefs;

  static const String _keyUser = 'user_data';

  Prefs(this._prefs);

  Future<bool> saveUser(UserModel user) async {
    return await _prefs.setString(_keyUser, jsonEncode(user.toJson()));
  }

  UserModel? getUser() {
    final jsonString = _prefs.getString(_keyUser);
    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return UserModel.fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }

  Future<bool> removeUser() async {
    return await _prefs.remove(_keyUser);
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }
}

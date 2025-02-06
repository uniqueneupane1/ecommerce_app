import 'dart:convert';

import 'package:ecommerce_app/features/auth/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseServices {
  final String _isFirstTime = "isFirstTime";
  final String _user = "user";
  final String _token = "token";

  Future<bool> get isFirstTime async {
    final instance = await SharedPreferences.getInstance();
    return instance.getBool(_isFirstTime) ?? true;
  }

  Future<void> setAppAsOpened() async {
    final instance = await SharedPreferences.getInstance();
    await instance.setBool(_isFirstTime, false);
  }

  Future<User?> getUser() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final encodedJsonData = instance.getString(_user);
      if (encodedJsonData != null) {
        final mapUser = Map<String, dynamic>.from(json.decode(encodedJsonData));
        return User.fromMap(mapUser);
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  Future<void> saveUser(User user) async {
    final instance = await SharedPreferences.getInstance();
    final mapUser = user.toMap();
    final encodedJsonData = json.encode(mapUser);
    await instance.setString(_user, encodedJsonData);
  }

  Future<void> removeUser() async {
    final instance = await SharedPreferences.getInstance();
    instance.remove(_user);
  }

  Future<String> getToken() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString(_token) ?? "";
  }

  Future<void> saveToken(String token) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString(_token, token);
  }

  Future<void> removeToken() async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove(_token);
  }
}

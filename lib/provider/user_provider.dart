import 'package:flutter/material.dart';
import 'package:insta_clone/model/user_model.dart';
import 'package:insta_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    notifyListeners();
  }
}

import 'package:eduka/utils/auth_methords.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';


class UserProvider with ChangeNotifier{
  UserModel? _users;
  final AuthMethods _authMethods = AuthMethods();

  UserModel get getUser => _users!;

  Future<void> refreshUser() async {
    UserModel users = await _authMethods.getUser();
    _users = users;
    notifyListeners();
  }
}
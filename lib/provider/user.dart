import 'package:flutter/material.dart';
import 'package:flutter_sec6_backend/model/user.dart';

class UserProvider extends ChangeNotifier {
  UserModel _userModel = UserModel();

  ///set User
  void setUser(UserModel value){
    _userModel = value;
    notifyListeners();
  }

  ///Get User
  UserModel getUser() => _userModel;
}
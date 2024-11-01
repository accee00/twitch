import 'package:flutter/material.dart';
import 'package:twitch/models/user.dart';

class UserProvider extends ChangeNotifier {
  Users _user = Users(uid: '', username: '', email: '');
  Users get user => _user;
  setUser(Users user) {
    _user = user;
    notifyListeners();
  }
}

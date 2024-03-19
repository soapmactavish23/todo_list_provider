// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/navigator/todo_list_navigator.dart';

import 'package:todo_list_provider/app/services/user/user_service.dart';

class TodoListAuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;
  TodoListAuthProvider({
    required firebaseAuth,
    required userService,
  })  : _firebaseAuth = firebaseAuth,
        _userService = userService;

  Future<void> logout() => _userService.logout();
  User? get user => _firebaseAuth.currentUser;

  void loadListener() {
    _firebaseAuth.userChanges().listen((_) => notifyListeners());
    _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        TodoListNavigator.to!
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        TodoListNavigator.to!
            .pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }
}

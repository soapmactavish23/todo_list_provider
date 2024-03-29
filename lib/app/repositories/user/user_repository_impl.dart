// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';

import 'package:todo_list_provider/app/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  UserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
            message:
                'Você se cadastrou no TodoList pelo Google, por favor utilize ele para entrar',
          );
        } else {
          throw AuthException(
            message: 'E-mail já utilizado, por favor escolha outro e-mail',
          );
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    String message = "Não foi possível efetuar login";
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      log(message, error: e, stackTrace: s);
      throw AuthException(message: e.message ?? message);
    } on FirebaseAuthException catch (e, s) {
      log(message, error: e, stackTrace: s);
      if (e.code == "firebase_auth/invalid-credential") {
        throw AuthException(message: "Login ou senha inválidos");
      }
      throw AuthException(message: e.message ?? message);
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      // final loginMethods =
      //     await _firebaseAuth.fetchSignInMethodsForEmail(email);
      // if (loginMethods.contains('password')) {
      //   await _firebaseAuth.sendPasswordResetEmail(email: email);
      // } else if (loginMethods.contains('google')) {
      //   throw AuthException(
      //       message:
      //           'Cadastro realizado com o google, não pode ser resetado a senha');
      // } else {
      //   throw AuthException(message: 'E-mail não cadastrado');
      // }
    } on PlatformException catch (e, s) {
      String message = 'Erro ao resetar a senha';
      log(message, error: e, stackTrace: s);
      throw AuthException(message: message);
    }
  }

  @override
  Future<User?> googleLogin() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final firebaseCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        var userCredential = await _firebaseAuth.signInWithCredential(
          firebaseCredential,
        );
        return userCredential.user;
      } else {
        throw AuthException(message: 'Não foi possível logar com o google');
      }
    } on FirebaseAuthException catch (e, s) {
      String message = 'Erro ao realizar login';
      log(message, error: e, stackTrace: s);
      throw AuthException(message: message);
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      user.reload();
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/main.dart';
import 'package:noteapp/models/user_model.dart';
import 'package:noteapp/utils/router_helper.dart';
import 'package:noteapp/utils/show_messages.dart';

class MyAuthProvider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestoreDB = FirebaseFirestore.instance;

  bool loading = false;

  MyAuthProvider() {
    nextScreen();
  }

  void nextScreen() {
    if (auth.currentUser == null) {
      Navigator.pushReplacementNamed(
        navigatorKey.currentContext!,
        RouterHelper.login,
      );
    } else {
      Navigator.pushReplacementNamed(
        navigatorKey.currentContext!,
        RouterHelper.home,
      );
    }
  }

  void login(String email, String password) async {
    _loading(true);
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!,
        RouterHelper.home,
        (value) => false,
      );
    } on FirebaseAuthException catch (err) {
      showMeg(err.message);
    } catch (error) {
      showMeg(error.toString());
    } finally {
      _loading(false);
    }
  }

  void register({
    required String name,
    required String email,
    required String password,
  }) async {
    _loading(true);
    final result = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    UserModel user = UserModel(result.user!.uid, name, email, DateTime.now());
    firestoreDB.collection('users').doc(result.user!.uid).set(user.toMap());
    Navigator.pushNamedAndRemoveUntil(
      navigatorKey.currentContext!,
      RouterHelper.home,
      (value) => false,
    );
    try {} on FirebaseAuthException catch (err) {
      showMeg(err.message);
    } catch (error) {
      showMeg(error.toString());
    } finally {
      _loading(false);
    }
  }

  void forgotPassword({required String email}) async {
    _loading(true);
    try {
      await auth.sendPasswordResetEmail(email: email);
      showMeg("Please check your email, link send", false);
    } on FirebaseAuthException catch (err) {
      showMeg(err.message);
    } catch (error) {
      showMeg(error.toString());
    } finally {
      _loading(false);
    }
  }

  void logout() async {
    _loading(true);
    try {
      await auth.signOut();
      Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!,
        RouterHelper.login,
        (value) => false,
      );
    } on FirebaseAuthException catch (err) {
      showMeg(err.message);
    } catch (error) {
      showMeg(error.toString());
    } finally {
      _loading(false);
    }
  }

  _loading(bool value) {
    loading = value;
    notifyListeners();
  }
}

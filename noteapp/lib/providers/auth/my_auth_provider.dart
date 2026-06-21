import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/main.dart';
import 'package:noteapp/utils/router_helper.dart';
import 'package:noteapp/utils/show_messages.dart';

class MyAuthProvider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool loading = false;
  
  void login(String email, String password) async {
    _loading(true);
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamed(navigatorKey.currentContext!, RouterHelper.home);
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
    try {} on FirebaseAuthException catch (err) {
      showMeg(err.message);
    } catch (error) {
      showMeg(error.toString());
    } finally {
      _loading(false);
    }
  }

  void logout() async {
    _loading(true);
    try {} on FirebaseAuthException catch (err) {
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

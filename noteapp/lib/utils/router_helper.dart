import 'package:flutter/material.dart';
import 'package:noteapp/models/note_model.dart';
import 'package:noteapp/screens/addNote/add_note_screen.dart';
import 'package:noteapp/screens/auth/forgot_password_screen.dart';
import 'package:noteapp/screens/auth/login_screen.dart';
import 'package:noteapp/screens/auth/register_screen.dart';
import 'package:noteapp/screens/home/home_screen.dart';
import 'package:noteapp/screens/splash/splash_screen.dart';
import 'package:noteapp/screens/updateNote/update_note_screen.dart';

class RouterHelper {
  static String initial = '/';
  static String login = '/login';
  static String register = '/register';
  static String forgotPassword = '/forgotPassword';
  static String home = '/home';
  static String newNote = '/newNote';
  static const String updateNote = '/updateNote';

  static Map<String, WidgetBuilder> routes() => {
    initial: (context) => SplashScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    forgotPassword: (context) => ForgotPasswordScreen(),
    home: (context) => HomeScreen(),
    newNote: (context) => AddNoteScreen(),
  };

  static onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case updateNote:
        {
          NoteModel note = settings.arguments as NoteModel;
          return MaterialPageRoute(
            builder: (context) => UpdateNoteScreen(note: note),
          );
        }
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:noteapp/providers/auth/my_auth_provider.dart';
import 'package:noteapp/screens/splash/splash_screen.dart';
import 'package:noteapp/utils/router_helper.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyAuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: RouterHelper.routes(),
        onGenerateRoute: (settings) => RouterHelper.onGenerateRoutes(settings),
        title: 'Note Application',
      ),
    );
  }
}

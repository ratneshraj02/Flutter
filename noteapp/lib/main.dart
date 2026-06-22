  import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:noteapp/providers/auth/my_auth_provider.dart';
import 'package:noteapp/providers/note/note_provider.dart';
import 'package:noteapp/utils/router_helper.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

final scaffoldMessagerKey = GlobalKey<ScaffoldMessengerState>();
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyAuthProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => NoteProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        routes: RouterHelper.routes(),
        onGenerateRoute: (settings) => RouterHelper.onGenerateRoutes(settings),
        title: 'Note Application',
        scaffoldMessengerKey: scaffoldMessagerKey,
        navigatorKey: navigatorKey,
      ),
    );
  }
}

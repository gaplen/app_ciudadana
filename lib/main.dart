import 'package:app_ciudadana/src/home_page.dart';
import 'package:app_ciudadana/src/pages/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Registro de usuarios',
      home: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              // Usuario autenticado
              return HomeScreen();
            } else {
              // Usuario no autenticado
              return LoginScreen(
                userID: '',
              );
            }
          }
        },
      ),

      // LoginScreen(
      //   userID: '',
      // ),
      // routes: {
      //   '/login': (context) => LoginScreen(
      //         userID: '',
      //       ),
      //   // '/registro': (context) => RegistroScreen(),
      // },

      // RegistroScreen(),
    );
  }
}

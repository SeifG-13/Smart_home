import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_home/core/app/app.dart';
import 'package:smart_home/Screens/forgot_password.dart';
import 'package:smart_home/Screens/login_screen.dart';
import 'package:smart_home/Screens/signup.dart';
import 'package:smart_home/Utilities/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        //  primarySwatch: Colors.red,
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/' : '/homeScreen',
      routes: {
        MyRoutes.homeScreen: (context) => SmartHomeApp(),
        MyRoutes.loginScreen: (context) => LoginScreen(),
        MyRoutes.signUp: (context) => SignUp(),
        MyRoutes.forgotPassword: (context) => ForgotPassword(),
      },
    );
  }
}

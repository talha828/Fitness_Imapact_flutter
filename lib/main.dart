import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_impact/user_account/login/forgot_password.dart';
import 'package:fitness_impact/user_account/login/login_page.dart';
import 'package:fitness_impact/user_account/signup/sign_page.dart';
import 'package:flutter/material.dart';

Future <void> main()async {
  await  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SafeArea(
        child: Scaffold(
          body:LoginPage() ,
        ),
      ) ,
    );
  }
}
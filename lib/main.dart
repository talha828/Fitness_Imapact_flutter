import 'package:camera/camera.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_impact/user_account/login/forgot_password.dart';
import 'package:fitness_impact/user_account/login/login_page.dart';
import 'package:fitness_impact/user_account/signup/sign_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'challenge_screen/challenge_creation.dart';
import 'main_page/main_screen_page.dart';

Future <void> main()async {
  await  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var cameras = await availableCameras();
  await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SafeArea(
        child: Scaffold(
          body:LoginPage(),
        ),
      ) ,
    );
  }
}

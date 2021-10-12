import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_impact/user_account/login/login_page.dart';
import 'package:fitness_impact/user_account/signup/button.dart';
import 'package:fitness_impact/user_account/signup/textfieldforsignup.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/background_image/fitnessImage.jpg',
                ),
                fit: BoxFit.fill),
          ),
          child: Container(
            padding: EdgeInsets.all(35),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xE626a271),
                    Color(0xE6125069),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.decal),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 5,
                    child: const Image(
                      image: AssetImage(
                        'assets/app_logo/app_logo.png',
                      ),
                      fit: BoxFit.cover,
                    )),
                TextFieldSignup(
                  text: 'Enter Your Email',
                  color: Colors.white,
                  password: false,
                  onchnage: (value){
                    email=value.trim();
                  },
                ),
                Button(text: 'next',onPress: (){
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  _auth.sendPasswordResetEmail(email: email).catchError((e)=> Alert(context: context,
                      title: "Check your email",
                      desc: "kindly check your email").show()).whenComplete(() =>Alert(context: context,
                      title: "Check your Mailbox",
                      desc: "Check your mail box.try to reset your password and login again",
                    closeFunction: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));},
                  ).show() );
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

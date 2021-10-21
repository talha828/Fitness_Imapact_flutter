import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_impact/main_page/main_screen_page.dart';
import 'package:fitness_impact/user_account/login/forgot_password.dart';
import 'package:fitness_impact/user_account/login/login_button.dart';
import 'package:fitness_impact/user_account/signup/button.dart';
import 'package:fitness_impact/user_account/signup/sign_page.dart';
import 'package:fitness_impact/user_account/signup/textfieldforsignup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;
  loginUser()async{
       FirebaseAuth _auth = FirebaseAuth.instance;
       if(email==null||password==null){
         Alert(context: context,
             title: "Fill all the credentials",
             desc: "please fill all the credentials for proceeding").show();
       }
       else{
         _auth.signInWithEmailAndPassword(email: email, password: password).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage())))
             .catchError((e)=>   Alert(context: context,
             title: "Check your email and password",
             desc: "kindly check your email and password").show());
       }

  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()))).catchError((e)=>Alert(context: context,
        title: "Something wants wrong",
        desc: "please retry something wanys wrong").show());
  }
  Future<UserCredential>  facebookLogin()async {
    final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
    FirebaseAuth _auth = FirebaseAuth.instance;
    final AuthCredential facebookCredential =
    FacebookAuthProvider.credential(result.accessToken!.token);
    return await _auth.signInWithCredential(facebookCredential).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()))).catchError((e)=>Alert(context: context,
        title: "Something wants wrong",
        desc: "please retry something wanys wrong").show());
  }
    @override
  Widget build(BuildContext context){
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
             const   SizedBox(
                  height: 10,
                ),
                const Text(
                  'BURN SOME',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const Text(
                  'FAT',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const Text(
                  'GET IN SHAPE',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                TextFieldSignup(
                  text: 'Enter Your Email',
                  color: Colors.white,
                  password: false,
                  onchnage: (value){
                    email=value.trim();
                  },
                ),
                TextFieldSignup(
                  text: 'Enter Your password',
                  color: Colors.white,
                  password: false,
                  onchnage: (value){
                    password=value.trim();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:  [
                      GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));},
                        child:const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Sign in with',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //TODO: google login
                      FloatingActionButton(
                        heroTag:'1',
                        onPressed: signInWithGoogle,
                        backgroundColor: Colors.white,
                        child:const Icon(
                          FontAwesomeIcons.google,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                      //TODO: facebook login
                      FloatingActionButton(
                        heroTag: '2',
                        onPressed: facebookLogin,
                        backgroundColor: Colors.white,
                        child: const Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blueAccent,
                          size: 30,
                        ),
                      ),
                      //TODO:Twitter lo
                      // gin
                      FloatingActionButton(
                        heroTag: '3',
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        child:const  Icon(
                          FontAwesomeIcons.twitter,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Button(
                  text: 'LOGIN',
                  onPress:loginUser ,
                ),
                const   SizedBox(
                  height: 20,
                ),
                SignupButtonInLogin()
              ],
            ),
          ),
        ),
      ),
    );
  }
}


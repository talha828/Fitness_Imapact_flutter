import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_impact/user_account/signup/button.dart';
import 'package:fitness_impact/main_screen_page.dart';
import 'package:fitness_impact/user_account/signup/sign_page.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
 class Verification extends StatefulWidget {
   Verification({this.verificationCode});
final verificationCode;
   @override
   _VerificationState createState() => _VerificationState();
 }

 class _VerificationState extends State<Verification> {
   final FocusNode _pinPutFocusNode = FocusNode();
   final TextEditingController _pinPutController = TextEditingController();

   BoxDecoration get _pinPutDecoration {
     return BoxDecoration(
       border: Border.all(color: Colors.deepPurpleAccent),
       borderRadius: BorderRadius.circular(15.0),
     );
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
         padding: const EdgeInsets.all(35),
         width: MediaQuery
             .of(context)
             .size
             .width,
         height: MediaQuery
             .of(context)
             .size
             .height,
         decoration: const BoxDecoration(
           gradient: LinearGradient(
               colors: [
                 Color(0xff26a271), Color(0xff125069),
               ],
               begin: Alignment.topLeft,
               end: Alignment.bottomRight,
               stops: [0.0, 1.0],
               tileMode: TileMode.clamp),
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             const Text('Verification Code',style: TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.bold,
               fontSize: 30
             ),),
             const SizedBox(height: 20,),
             const Text('Please enter Code that was',style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.w300,
                 fontSize: 20
             ),),
            const  Text('sent to phone number',style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.w300,
                 fontSize: 20
             ),),
             const SizedBox(height: 20,),
             PinPut(fieldsCount: 6,
              controller: _pinPutController,
               textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
               autovalidateMode: AutovalidateMode.always,
              disabledDecoration:_pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
               selectedFieldDecoration:_pinPutDecoration.copyWith(
                 borderRadius: BorderRadius.circular(10.0),
                 border: Border.all(
                   color: Colors.white,
                 ),
               ),
               followingFieldDecoration:_pinPutDecoration.copyWith(
                 borderRadius: BorderRadius.circular(10.0),
                 border: Border.all(
                   color: Colors.white,
                 ),
               ),
             ),
          const   SizedBox(height: 20,),
             Button(text: 'Verified',onPress: (){
               FirebaseAuth auth = FirebaseAuth.instance;

               var smsCode = _pinPutController.text.trim();

               var _credential = PhoneAuthProvider.credential(verificationId: widget.verificationCode, smsCode: smsCode);
               auth.signInWithCredential(_credential).then((value) {
                 Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (context) =>MainPage())).catchError((e)=>Alert(context: context,
                     title: "some thing wants wrong",
                     desc: "please try again ").show().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>SignPage()))));
               });
             },),
           ],
         ),
       ),
     );
   }
 }

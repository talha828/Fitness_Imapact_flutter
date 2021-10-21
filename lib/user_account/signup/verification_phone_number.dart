
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_impact/user_account/signup/button.dart';
import 'package:fitness_impact/main_page/main_screen_page.dart';
import 'package:fitness_impact/user_account/signup/sign_page.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cross_file/cross_file.dart';

 class Verification extends StatefulWidget {
   Verification({this.verificationCode,this.email,this.name,this.password,this.phoneNumber,this.photo});
final verificationCode;
final name;
final email;
final password;
final phoneNumber;
final photo;


   @override
   _VerificationState createState() => _VerificationState();
 }

 class _VerificationState extends State<Verification> {
   final FirebaseAuth _auth=FirebaseAuth.instance;
   saveData()async{
           if(widget.photo!=null){
             firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
             firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('Profile_Image').child(widget.email);
             var data = await  ref.putFile(widget.photo).catchError((e)=>print(e));
             String downloadUrl = await (await data.ref.getDownloadURL().catchError((e)=>  Alert(context: context,
                 desc: "please check somethings wants gets wrongs",
                 title: "Something wants wrongs").show()));
             CollectionReference users = FirebaseFirestore.instance.collection('users_Data');
             print(downloadUrl);
             var putData =users.doc(widget.email).set({
               'User_name':widget.name,
               'user_uid':_auth.currentUser!.uid,
               'user_email':widget.email,
               'user_phone_number':widget.phoneNumber,
               'user_password':widget.password,
               'user_image':downloadUrl,
             }).catchError((e)=>  Alert(context: context,
                 title: "Something wants wrongs",
                 desc: "please check somethings wants gets wrongs").show()).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage())));
           }
           else{
             print('sorry world');
           }
   }

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
                 saveData();
                 Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (context) =>MainPage())).catchError((e){Alert(context: context,
                     title: "some thing wants wrong",
                     desc: "please try again ").show();
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>SignPage()));
                     });
               });
             },),
           ],
         ),
       ),
     );
   }
 }

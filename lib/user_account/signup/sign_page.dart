import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_impact/user_account/signup/button.dart';
import 'package:fitness_impact/main_page/main_screen_page.dart';
import 'package:fitness_impact/user_account/signup/textfieldforsignup.dart';
import 'package:fitness_impact/user_account/signup/verification_phone_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:firebase_auth/firebase_auth.dart';







class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  dynamic val = 1;// for radio button out put selection
  bool photos=false;// profile image checker
  var photo;// save photo as xFile format
  var image;
   var file;
String Images='assets/simple_icon/images.png';
  // this function is for getting profile image
  getImage() async {
    if (val == 1) {
      var status = await Permission.camera.request();
      var galleryPermission = await Permission.photosAddOnly.status;
      if (status.isDenied) {
        Alert(context: context,
            title: "Camera Permission is denied ",
            desc: "Please enable the camera permission ").show();
      }
      if (status.isGranted) {
        final ImagePicker _picker = ImagePicker();
        final XFile? photo = await _picker.pickImage(
            source: ImageSource.camera);
        setState(() {
          photos=true;
           file= File(photo!.path);

        });
      }
    }
    if(val==2){
      final ImagePicker _picker = ImagePicker();
       photo = await _picker.pickImage(source: ImageSource.gallery).catchError((e){print(e);print('wrong');});
      setState(() {
        photos=true;
        file= File(photo!.path);
      });
    }
  }
   String name='';
   String email='';
   String password='';
   String confirmPassword='';
   String phoneCode='';
   String phoneNumber='';
  //this funtion is use to sign up account
  saveData()async{
  if(file!=null){
    firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('Profile_Image').child(email);
    var data = await ref.putFile(photo);
    var link = ref.getDownloadURL().catchError((e)=>  Alert(context: context,
        title: "Something wants wrongs",
        desc: "please check somethings wants gets wrongs").show());
    FirebaseAuth _auth=FirebaseAuth.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('users_Data');
    print(link);
    var putData =users.doc(email).set({
      'User_name':name,
      'user_uid':_auth.currentUser!.uid,
      'user_email':email,
      'user_phone_number':phoneNumber,
      'user_password':password,
      'user_image':link,
    }).catchError((e)=>  Alert(context: context,
        title: "Something wants wrongs",
        desc: "please check somethings wants gets wrongs").show()).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage())));

  }
  else{
    print('sorry world');
  }
  }
  signAccount(){
    if(name==''||email==''||password==''||confirmPassword==''||phoneCode==''||phoneNumber==''){
      Alert(context: context,
          title: "Fill all the credentials",
          desc: "please fill all the credentials for proceeding").show();
    }
    else if(name!=null&&email!=null&&password!=null&&confirmPassword!=null&&phoneCode!=null&&phoneNumber!=null){
      FirebaseAuth _auth = FirebaseAuth.instance;
     if(password==confirmPassword){
      _auth.createUserWithEmailAndPassword(email: email, password: password).catchError((e){Alert(context: context,
      title: "check the email and password",
      desc: "password can`t be less the 8 character").show();
      }).whenComplete(() => _auth.verifyPhoneNumber(
          phoneNumber: '${phoneCode +phoneNumber}',
          verificationCompleted:  (PhoneAuthCredential credential)async{
              await saveData();
            _auth.signInWithCredential(credential).then((value){Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));});
          },
          verificationFailed:(authException){
            print(authException.message);
            print('vericifation field');
          },
          codeSent: (String verificationId, [int? forceResendingToken]){
            //show dialog to take input from the user
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Verification(verificationCode: verificationId,name: name,password: password,email: email,phoneNumber: phoneNumber,photo: file,),// Verification(verificationId:verificationId, country: country, name: widget.name, number: number,)
            );
          },
          codeAutoRetrievalTimeout:(String verificationId){
      verificationId = verificationId;
      print(verificationId);
      print("Timout");
      })).catchError((e){Alert(context: context,
          title: "check phone number",
          desc: "Make sure your Phone number is valid (+92 3012070920)").show();});}

     else{
       Alert(context: context,
           title: "check the password",
           desc: "your password don`t match").show();
     }
    }
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: SingleChildScrollView(
          child: Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sign Up', style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),),
                  const Text('Welcome To our App Please sign for proceed ',
                    style: TextStyle(
                        color: Colors.white
                    ),),
                  Row(
                    children: [
                      // sign page image content
                      GestureDetector(onTap: getImage,
                          child:  CircleAvatar(radius: 45,
                            backgroundColor: Colors.white,
                            child:(photos==false)?Image.asset(Images,scale: 7,):const Icon(Icons.check,color: Colors.green,size: 45,))),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // radio button for picture selection
                          Row(children: [
                            Theme(data: ThemeData(unselectedWidgetColor: Colors
                                .white,), child: Radio(value: 1,
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  val = value;
                                });
                              },
                              activeColor: Colors.white,)),
                            const Text('Take a Picture', style: TextStyle(
                                color: Colors.white, fontSize: 16)),
                          ],),
                          Row(children: [
                            Theme(data: ThemeData(unselectedWidgetColor: Colors
                                .white,), child: Radio(value: 2,
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  val = value;
                                });
                              },
                              activeColor: Colors.white,)),
                            const Text('Select from gallery', style: TextStyle(
                                color: Colors.white, fontSize: 16)),
                          ],),
                        ],
                      ),
                    ],
                  ),
                  TextFieldSignup(text: 'Enter your Name',
                    color: Colors.white,
                    password: false,
                  onchnage: (value){
                    name=value;
                  },
                  ),
                  TextFieldSignup(text: 'Enter your Email',
                    color: Colors.white,
                    password: false,
        onchnage: (value){
        email=value;}),
                  Row(children: [
                    SizedBox(width: 70,
                        child: TextFieldSignup(text: '+92',
                          color: const Color(0xff70ce55),
                          password: false,  onchnage: (value){
                              phoneCode=value.trim();})),
                    const SizedBox(width: 10,),
                    SizedBox(width: 200,
                        child: TextFieldSignup(text: 'Enter your Number',
                          color: Colors.white,
                          password: false,  onchnage: (value){
                              phoneNumber=value.trim();})),
                  ],),
                  TextFieldSignup(text: 'Enter your password',
                    color: Colors.white,
                    password: false,  onchnage: (value){
                        password=value;}),
                  TextFieldSignup(text: ' Confirm Password',
                    color: Colors.white,
                    password: false,  onchnage: (value){
                        confirmPassword=value;}),
                  const SizedBox(height: 10,),
                  Button(text: 'Sign up',onPress: signAccount,),
                ],
              )
          ),
        ),
      );
    }
  }




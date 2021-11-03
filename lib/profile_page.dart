import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_impact/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'challenge_screen/challenge_creation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main_page/exeriese_catalog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users_Data');
 FirebaseAuth _auth =FirebaseAuth.instance;
  @override  List<Widget> items =[ExercieseCatalog(),ExercieseCatalog(),ExercieseCatalog(),ExercieseCatalog()];

  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(children: [
                GestureDetector( onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateChallenge())),child:  Container(child:  const Icon(FontAwesomeIcons.edit,size: 30,color: Color(0xff2cb670),))),
                Expanded(child: Container(alignment: Alignment.center,child: Image.asset('assets/app_logo/small_logo.png',width: MediaQuery.of(context).size.width/1.8,))),
                GestureDetector(child: Container(child: const Icon(FontAwesomeIcons.solidBell,size: 30,color: Color(0xff2cb670),))),
              ],),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 170,
                child: StreamBuilder(
                  stream:  FirebaseFirestore.instance.collection('users_Data').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(!snapshot.hasData){
                      return CircularProgressIndicator();
                    }
                    return ListView(
                      children: snapshot.data!.docs.reversed.map((data) =>ListTile(
                        contentPadding:const EdgeInsets.symmetric(vertical: 40,horizontal: 30),
                        leading: Container(
                          width: 55,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(data['user_image'],),fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black)
                          ),

                        ),
                        title: Text(data['User_name'],style: TextStyle(
                          fontSize: 25,
                          color: Colors.black
                        ),),
                        subtitle: Text('2 Session Left',style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff28b476),
                        ),),
                      )).toList(),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileButton(text: 'WorkOut',color: Colors.grey,fontWeight: FontWeight.normal,),
                  ProfileButton(text: 'Challenges',color: Colors.grey,fontWeight: FontWeight.normal),
                  ProfileButton(text: 'Video',color: Color(0xff28b476),fontWeight: FontWeight.bold,),
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: ListView(

                    children:items ,
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    ));
  }
}



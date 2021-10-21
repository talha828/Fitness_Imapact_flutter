import 'package:fitness_impact/challenge_screen/challenge_creation.dart';
import 'package:fitness_impact/user_account/signup/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'category_options.dart';
import 'exeriese_catalog.dart';
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
 //TODO : simple list
  List<Widget> items =[ExercieseCatalog(),ExercieseCatalog(),ExercieseCatalog(),ExercieseCatalog()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
       width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  GestureDetector( onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateChallenge())),child:  Container(child:  const Icon(FontAwesomeIcons.edit,size: 30,color: Color(0xff2cb670),))),
                  Expanded(child: Container(alignment: Alignment.center,child: Image.asset('assets/app_logo/small_logo.png',width: MediaQuery.of(context).size.width/1.8,))),
                  GestureDetector(child: Container(child: const Icon(FontAwesomeIcons.solidBell,size: 30,color: Color(0xff2cb670),))),
                ],),
                Container(padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                  child: const Text('what would you do Today',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],              ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      suffixIcon: Icon(FontAwesomeIcons.search,color: Color(0xff2cb670) ,),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Category_ball(text: 'Crossfit',),
                    Category_ball(text: 'Fitness',),
                    Category_ball(text: 'Gymnastic',),
                    Category_ball(text: 'Athletics',),
                  ],),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                  child: const Text('Workout Plane',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                ),
               SingleChildScrollView(
                 child: Container(
                   width: MediaQuery.of(context).size.width,
                   height: 190,
                   child: ListView(
                     scrollDirection: Axis.horizontal,
                     children:items ,
                   ),
                 ),
               )
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(onPressed: (){},heroTag:'1',child: Icon(FontAwesomeIcons.home,color: Colors.grey,),backgroundColor: Colors.white,elevation: 0,),
                  FloatingActionButton(onPressed: (){},heroTag:'2',child: Icon(FontAwesomeIcons.dumbbell,color:  Color(0xff2cb670),),backgroundColor: Colors.white,elevation: 0,),
                  FloatingActionButton(onPressed: (){},heroTag:'3',child: Icon(FontAwesomeIcons.camera,color: Colors.white,),backgroundColor: Color(0xff2cb670),),
                  FloatingActionButton(onPressed: (){},heroTag:'4',child: Icon(FontAwesomeIcons.trophy,color: Colors.grey,),backgroundColor: Colors.white,elevation: 0,),
                  FloatingActionButton(onPressed: (){},heroTag:'5',child: Icon(FontAwesomeIcons.userAlt,color: Colors.grey,),backgroundColor: Colors.white,elevation: 0,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

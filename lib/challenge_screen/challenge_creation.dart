import'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:date_field/date_field.dart';

import 'challenge_fields.dart';

class CreateChallenge extends StatefulWidget {
  const CreateChallenge({Key? key}) : super(key: key);

  @override
  _CreateChallengeState createState() => _CreateChallengeState();
}

class _CreateChallengeState extends State<CreateChallenge> {

  String dropdownvalue = 'Apple';
  var items =  ['Apple','Banana','Grapes','Orange','watermelon','Pineapple'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   GestureDetector(onTap: ()=>Navigator.pop(context), child: Container(child: FloatingActionButton(elevation: 0,onPressed: (){},child: Icon(FontAwesomeIcons.arrowLeft,color: Color(0xff29b672),),backgroundColor: Colors.white,))),
                   Expanded(child: Container(alignment: Alignment.center,child: Image.asset('assets/app_logo/small_logo.png',width: MediaQuery.of(context).size.width/1.8,))),
                 ],
               ),
            SizedBox(height: 30,),
            Text('Create Challenge',style: TextStyle(fontSize: 24,),),
            SizedBox(height: 30,),
            DroupField(dropdownvalue: dropdownvalue, items: items,text: 'category' ,onchange:(newValue) async {setState(() {dropdownvalue = newValue.toString();});},),
            DroupField(dropdownvalue: dropdownvalue, items: items,text: 'WortOut type' ,onchange:(newValue) async {setState(() {dropdownvalue = newValue.toString();});},),

            Container(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Timeout Interval :',style: const TextStyle(fontSize: 22,color:Color(0xff29b672) ),),
                  Container(
                    width: 140,
                    height: 100,
                    child: DateTimeFormField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                        labelText: 'Only time',
                      ),
                      mode: DateTimeFieldPickerMode.time,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                      onDateSelected: (DateTime value) {
                        print(value);
                      },
                    ),
                  ),              ],),
            ),
            ChallengeFileds(text: 'fees',),
            ChallengeFileds(text: 'Prize',),
            SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              width: 150,
              height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        const Color(0xff67bc47),
                        const Color(0xff2cb670),
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.circular(30),
                  color:Color(0xff29b672),

                ),
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child:Text('Create',style: TextStyle(
                fontSize: 18,
                color: Colors.white
              ),),
            ),
          ],
        ),
      ),
    );
  }
}

class DroupField extends StatelessWidget {
  const DroupField({
    Key? key,
    this.text,
    required this.dropdownvalue,
    required this.items,
    this.onchange,
  }) : super(key: key);

  final String dropdownvalue;
  final List<String> items;
  final onchange;
  final text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
        Text('$text :',style: TextStyle(fontSize: 22,color:Color(0xff29b672) ),),
        SizedBox(width: 20,),
        DropdownButton(
          value: dropdownvalue,
          icon: Icon(Icons.keyboard_arrow_down),
          items:items.map((String items) {
            return DropdownMenuItem(
                value: items,
                child: Text(items)
            );
          }
          ).toList(),
          onChanged: onchange,
        ),
      ],),
    );
  }
}

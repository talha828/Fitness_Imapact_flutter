import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ChallengeFileds extends StatelessWidget {
  ChallengeFileds({this.text,this.onchange});
  final text;
  final onchange;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Text('$text :',style: TextStyle(fontSize: 22,color:Color(0xff29b672) ),),
          SizedBox(width: 30,),
          Container(
              width: 200,
              height: 100,
              child: TextField(
                onChanged: onchange,
                decoration: InputDecoration(
                    hintText: '10',
                    hintStyle: TextStyle(
                      fontSize: 20,
                    ),
                    prefixIcon: Icon(FontAwesomeIcons.dollarSign)
                ),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}

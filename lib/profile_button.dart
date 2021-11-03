import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
 ProfileButton({this.text,this.onTap,this.color,this.fontWeight});
final text;
final onTap;
final color;
final fontWeight;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: color))
        ),
        child:Text(text,style: TextStyle(
            color:color,
            fontSize: 18,fontWeight: fontWeight
        ),),),
    );
  }
}
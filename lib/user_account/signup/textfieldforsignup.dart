import 'package:flutter/material.dart';


class TextFieldSignup extends StatelessWidget {
TextFieldSignup({this.text,this.color,this.onchnage,this.password});
final text;
final color;
final onchnage;
final password;
  @override
  Widget build(BuildContext context) {
    return  TextField(

      style: const TextStyle(
          color: Colors.white),
      obscureText: password,
      decoration: InputDecoration(
        // focusedBorder: InputBorder.none,
        // enabledBorder: InputBorder.none,
        filled: true,
        fillColor: Colors.transparent,
        hintText: text,
        hintStyle: TextStyle(
          color: color,
        ),
        focusedBorder:const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      onChanged: onchnage,
    );
  }
}

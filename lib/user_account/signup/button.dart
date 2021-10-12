import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({this.text,this.onPress});
  final text;
  final onPress;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPress,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 60),
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              gradient:const LinearGradient(
                  colors: [
                    Color(0xff61ba46), Color(0xff2faa4d),
                  ],
                  begin:  Alignment.topLeft,
                  end:Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Text( text,style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
            ),),
          ),
        ),
      ],
    );
  }
}

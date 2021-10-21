import 'package:flutter/material.dart';

class Category_ball extends StatelessWidget {
  Category_ball({this.onPress,this.text});
  final text;
  final onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image:const DecorationImage(image: AssetImage('assets/sample_video/sample_image.jpg',),fit: BoxFit.cover)
              ),
            ),
            const  SizedBox(height: 5,),
            Text(text,style:const TextStyle(
                color: Color(0xff2cb670),
                fontSize: 15,
              fontWeight: FontWeight.bold
            ),),

          ],
        ),
      ),
    );
  }
}


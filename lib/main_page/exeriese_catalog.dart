import 'package:flutter/material.dart';


class ExercieseCatalog extends StatelessWidget {
  const ExercieseCatalog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Container(
        width: 150,
        padding: EdgeInsets.all(10),
        height: 180,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image:AssetImage('assets/sample_video/sample_image.jpg'),fit: BoxFit.cover)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('1 hour',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
            Text('12  exerciese',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
            SizedBox(height: 80,),
            Text('Legs Toning and Gultes workout',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 17),),

          ],
        ),
      ),
    );
  }
}


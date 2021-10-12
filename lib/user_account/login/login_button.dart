import 'package:fitness_impact/user_account/signup/sign_page.dart';
import 'package:flutter/material.dart';

class SignupButtonInLogin extends StatelessWidget {
  const SignupButtonInLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignPage())),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 2,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xE626a271), width: 3)),
          child:const  Text(
            'SIGNUP ',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}

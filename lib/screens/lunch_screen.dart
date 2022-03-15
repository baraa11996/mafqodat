import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfqodaty/controller/fb_auth_controller.dart';
import 'package:mfqodaty/prefs/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LunchScreen extends StatefulWidget {
  const LunchScreen({Key? key}) : super(key: key);

  @override
  _LunchScreenState createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      String route = SharedPrefController().logged ? '/home_screen' : '/login_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/1234.gif'),
            fit: BoxFit.cover,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children:  [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   width: 60,
                //   height: 60,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(25),
                //   ),
                //   child: Image.asset('images/logo.png',fit: BoxFit.cover,),
                // ),
                SizedBox(width: 10,),
                Text('تطبيق  مفقوداتي ',style: TextStyle(fontSize: 25,fontFamily: 'Noto',color: Colors.indigoAccent,fontWeight: FontWeight.bold),)
              ],
            ),
            SizedBox(height: 25,),
          ],
        ),
      ),
    );
  }
}

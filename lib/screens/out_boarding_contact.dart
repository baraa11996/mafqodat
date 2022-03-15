
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OutBoardingContent extends StatelessWidget {
  const OutBoardingContent({
    Key? key,
    required this.text,
     this.text2='',
    this.text3='',
    required this.image,
    required this.height,
    required this.width,
  }) : super(key: key);

  final String text;
  final String text2;
  final String text3;
  final String image;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          ' مفقوداتي',
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Noto',
          ),
        ),
        SizedBox(height: 10,),
        Text(text,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontFamily: 'Noto',),),
        SizedBox(height: 10,),
        Text(text2,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontFamily: 'Noto'),),
        SizedBox(height: 10,),
        Text(text3,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontFamily: 'Noto'),),
        Image(
          height:height,
          width:width,
          image: AssetImage(image),
        ),
      ],
    );
  }
}

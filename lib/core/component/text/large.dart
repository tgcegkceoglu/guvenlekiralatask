import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  String text;
  double? top;
  double? bottom;
  double? height;
  LargeText({super.key,required this.text,this.top,this.bottom,this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.fromLTRB(0, top ?? 0, 0, bottom ?? 0),
      child: Text(text,style: Theme.of(context).textTheme.headlineLarge!.copyWith(height: height),textAlign: TextAlign.center,),
    );
  }
}
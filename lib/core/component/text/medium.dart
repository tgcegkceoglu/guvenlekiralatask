import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {
  String text;
  double? top;
  double? bottom;
  double? size;
  Color? color;
  TextAlign? align;
  double? height;
  MediumText({super.key,required this.text,this.top,this.bottom,this.color,this.align,this.height,this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.fromLTRB(0, top ?? 0, 0, bottom ?? 0),
      child: Text(text,style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: color,height: height,fontSize: size),textAlign: align,)
    );
  }
}
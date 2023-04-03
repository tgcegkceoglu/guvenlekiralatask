import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  String text;
  double? top;
  double? left;
  double? right;
  FontWeight? weight;
  double? bottom;
  double? height;
  double? size;
  Color? color;
  TextAlign? textAlign;
  SmallText({super.key,required this.text,this.top,this.bottom,this.height,this.color,this.textAlign,this.size,this.left,this.weight,this.right});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.fromLTRB(left ?? 0, top ?? 0,right ?? 0, bottom ?? 0,),
      child: Text(text,style: Theme.of(context).textTheme.bodySmall!.copyWith(height: height,color: color,fontSize: size,fontWeight: weight),textAlign: textAlign ?? TextAlign.start,),
    );
  }
}
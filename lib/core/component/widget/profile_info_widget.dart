import 'package:flutter/material.dart';
import 'package:guvenlekirala/core/component/text/Small.dart';

class ProfileInfoWidget extends StatelessWidget {
  String header;
  String title;
  bool isRow;
  ProfileInfoWidget({super.key,required this.header, required this.title,required this.isRow});

  @override
  Widget build(BuildContext context) {
    return isRow ? Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SmallText(text: header, color:Color(0xFF006AFF),size: 11, right: 8,),
      SizedBox(width: MediaQuery.of(context).size.width/2, child:SmallText(text: title, color: Color(0xFF484848),size: 11,bottom: 5,)),
    ],
  ) : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SmallText(text: header, color:Color(0xFF006AFF),size: 11,bottom: 5,),
      SizedBox(width: MediaQuery.of(context).size.width/2, child:SmallText(text: title, color: Color(0xFF484848),size: 11,)),
    ]);
  }
}
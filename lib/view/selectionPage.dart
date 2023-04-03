import 'package:flutter/material.dart';
import 'package:guvenlekirala/core/component/text/medium.dart';
import 'package:guvenlekirala/core/component/text/small.dart';

class SelectionPage extends StatelessWidget {
  List list;
  String header;
  String title;
 SelectionPage({super.key,required this.list,required this.header, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF006AFF),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )
                ),
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(onPressed: (){Navigator.pop(context);},icon: const Icon(Icons.arrow_back, color: Color(0xFF484848),)),
            ),
           body: Container(
            width: MediaQuery.of(context).size.width,
            padding:const EdgeInsets.only(bottom: 20,left: 20,right: 20),
            color: Colors.white,
             child:Column(
                  children: [
                  MediumText(text: header,align: TextAlign.center,bottom: 10,),
                  SmallText(text: title,textAlign: TextAlign.center,bottom: 38,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.pop(context,list[index]);
                          },
                          child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: list[index],
                              hintStyle: Theme.of(context).textTheme.bodySmall!,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ],
            )
          )
        )
      )
    );
  }
}
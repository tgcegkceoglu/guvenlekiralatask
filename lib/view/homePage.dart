import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guvenlekirala/core/component/message/msg.dart';
import 'package:guvenlekirala/core/component/text/medium.dart';
import 'package:guvenlekirala/core/component/text/small.dart';
import 'package:guvenlekirala/core/component/widget/profile_info_widget.dart';
import 'package:guvenlekirala/core/firebase/user_add_firebase.dart';
import 'package:guvenlekirala/core/firebase/firebase_service.dart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  List<UserAddFirebase> _users = [];
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, '/expressYourself');
      },child: Icon(Icons.add,color: Colors.white,),backgroundColor:Color(0xFF006DFF)),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 0,
        toolbarHeight: 80,
        title: SvgPicture.asset("assets/images/logo.svg"),
      ),
      body: FutureBuilder<List<UserAddFirebase>>(
      future: readAllUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<UserAddFirebase>> snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return msg(context, "Bir Hata Oluştu!");
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: MediumText(text: "Herhangi Bir Kullanıcı Eklemediniz!",color: Color(0xFF006AFF),));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              UserAddFirebase user = snapshot.data![index];
              return Container(
                margin: EdgeInsets.only(right: 20,left: 20,bottom: 18,top: index == 0 ? 10 : 0),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow:[
                    BoxShadow(
                    color: Color(0xFF006AFF).withOpacity(.25),
                    offset: Offset(3,6),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1,color: Color(0xFF484848)) 
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText(text: "Kullanıcı ${index+1}",color: Color(0xFF006AFF),bottom: 10,top: 5, size: 13,weight: FontWeight.bold,),
                    Row(
                      children: [
                        user.image != null ? 
                        CircleAvatar(radius: 25, backgroundImage:NetworkImage(user.image.toString())) : 
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(34)),
                          child: SvgPicture.asset("assets/images/profile.svg")
                        ),
                        SizedBox(width: 25,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                             ProfileInfoWidget(header:"Cinsiyet",title:user.gender,isRow:true),
                             ProfileInfoWidget(header:"Pet Dost",title:user.petFriend,isRow:true),
                             ProfileInfoWidget(header:"Açıklama",title:user.description,isRow:false),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    ),

    );
  }


}
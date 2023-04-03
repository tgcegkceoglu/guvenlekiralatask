import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guvenlekirala/core/component/message/msg.dart';
import 'package:guvenlekirala/core/component/text/Small.dart';
import 'package:guvenlekirala/core/component/text/large.dart';
import 'package:guvenlekirala/core/component/text/medium.dart';
import 'package:guvenlekirala/core/firebase/firebase_service.dart.dart';
import 'package:guvenlekirala/view/selectionPage.dart';
import 'package:image_picker/image_picker.dart';
class ExpressYourself extends StatefulWidget {
  const ExpressYourself({Key? key}) : super(key: key);

  @override
  State<ExpressYourself> createState() => _ExpressYourselfState();
}

class _ExpressYourselfState extends State<ExpressYourself> {
  File? _selectedFile;
  var eduResult;
  var incomeResult;
  bool _nullCheck=false;
  String gender="Kadın";
  bool petFriend=true;
  bool addIncome=true;
  String petFriendCount="1";
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _salary = TextEditingController();
  final TextEditingController _rentAmount = TextEditingController();
  RangeValues _values = const RangeValues(0, 100000);

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
              bottom: PreferredSize(preferredSize: const Size.fromHeight(0.1),child: Container(height: 1, color: const Color(0xFFEDE8E9)),),
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(onPressed: (){Navigator.pop(context);},icon: const Icon(Icons.arrow_back, color: Color(0xFF484848),)),
              title: LargeText(text: "Kendini İfade Et!",height: 1.5,)
            ),
           body: Container(
            width: MediaQuery.of(context).size.width,
            padding:const EdgeInsets.only(bottom: 20,left: 20,right: 20),
            color: Colors.white,
             child: CustomScrollView(
               slivers: [
                 SliverFillRemaining(
                   hasScrollBody: false,
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      Stack(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            margin: const EdgeInsets.only(bottom: 18,top: 20),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color:_selectedFile == null ? const Color(0xFF000000).withOpacity(0.2) : const Color(0xFFE5EDFF),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child:_selectedFile == null ? SvgPicture.asset('assets/images/profile.svg') : 
                            CircleAvatar(radius: 34, backgroundImage: FileImage(_selectedFile!),),
                          ),
                          _selectedFile !=null ? Positioned(
                            top: 25,
                            right: 5,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _selectedFile=null;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(color:const Color(0xFF908E8E),borderRadius: BorderRadius.circular(5)),
                                child: SvgPicture.asset("assets/images/delete.svg"),
                              ),
                            ),
                          ):Container(),
                        ],
                      ) ,
                      MediumText(text: "Profil Fotoğrafı",bottom: 10,),
                      SmallText(text: "Aydınlık ve belirgin bir profil fotoğrafı, başvurunuzu öne çıkarmak için oldukça önemlidir. :)",height: 1.375,),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: (){
                          _choosePhoto(context);
                        },
                        child: Container(
                          width: _selectedFile != null ? MediaQuery.of(context).size.width : null,
                          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 35),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1,color: const Color(0xFF006AFF))
                          ),
                          child: _selectedFile != null ? SmallText(text:"Profil Fotoğrafımı Değiştir",color:const Color(0xFF006AFF),textAlign: TextAlign.center,)  : SmallText(text:"Ekle",color:const Color(0xFF006AFF),textAlign: TextAlign.center,)
                          
                        ),
                      ),
                      MediumText(text: "Cinsiyetiniz",bottom: 18,top: 40,),
                      _buildList(list: const ["Kadın","Erkek","Diğer",],isColumn: true,deger: "gender"),
                      MediumText(text: "Pet Dostunuz Var mı?",bottom: 18,top: 40,),
                      _buildList(list: const [true,false],isColumn: false,deger: "petFriend"),
                      petFriend ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MediumText(text: "Pet Dost Sayısı",bottom: 18,top: 40,),
                           _buildList(list: const ["1","2","3+",],isColumn: true,deger: "petFriendCount"),
                        ],
                      ) : Container(),
                      MediumText(text:"Eğitim Durumunuz:",top: 40, bottom: 18,),
                      _buildSelectionPage(text:"Lütfen Seçiniz",resultValue: "edu",route:SelectionPage(list: const ["Doktora", "İlkokul","Lise","Üniversite"],header: "Eğitim Durumunuz",title: "Eğitim durumunuzu seçiniz..",),icon:Icons.keyboard_arrow_down_rounded,enabled: false),
                      MediumText(text:"Aylık Net Maaş",top: 40, bottom: 18,),
                      _buildSelectionPage(text:"25.000",enabled: true, icon:"TL",controller: _salary,keyboard:  TextInputType.number),
                      MediumText(text:"Ek Geliriniz Var mı?",top: 40, bottom: 18,),
                      _buildList(list: const [true,false],isColumn: false,deger: "addIncome"),
                      addIncome ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            MediumText(text:"Gelir Tipi:",top: 40, bottom: 18,height: 1.375,),
                            _buildSelectionPage(text:"Lütfen Seçiniz",resultValue: "income",route:SelectionPage(list: const ["Gelir Tipi 1","Gelir Tipi 2","Gelir Tipi 3"],header: "Gelir Tipi", title: "Gelir Tipini Seçiniz",),icon:Icons.keyboard_arrow_down_rounded,enabled: false),
                            const SizedBox(height:23,),
                          GestureDetector(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.add,color: Color(0xFF006AFF),size: 19,),
                                const SizedBox(width: 12,),
                                SmallText(text: "Gelir Ekle",color: const Color(0xFF006AFF),)
                              ],
                            ),
                          ),
                        ],
                      ) : Container(),
                      MediumText(text:"Mevcut Kira Miktarınız",top: 40, bottom: 18,height: 1.375,),
                      _buildSelectionPage(text:"7.000",icon:"TL",enabled: true,controller: _rentAmount,keyboard: TextInputType.number),
                      MediumText(text: "Kiralamak İstediğiniz Mülkün\nFiyat Aralığı",top: 40,bottom: 18,height:1.375),
                      SliderTheme(
                        data: const SliderThemeData(
                          inactiveTrackColor: Color(0xFF908E8E),
                          activeTrackColor: Color(0xFF006AFF),
                          thumbColor: Colors.white,
                          trackHeight: 5,
                         rangeThumbShape: RoundRangeSliderThumbShape(
                          elevation: 3,
                         ),
                        ),
                        child: RangeSlider(
                          min: 0,
                          max: 100000,
                          values: _values,
                          onChanged: (RangeValues values) {
                            setState(() {
                              _values = values;
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText(text: "En Düşük",top: 19,bottom: 10,size:13),
                          SmallText(text: "En Yüksek",top: 19,bottom: 10,size: 13,),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSelectionPage(icon: "TL",text:_values.start.toInt().toString(),width:  (MediaQuery.of(context).size.width-40)/2-27.5,enabled: false),
                          _buildSelectionPage(icon: "TL",text:_values.end.toInt().toString(),width:  (MediaQuery.of(context).size.width-40)/2-27.5,enabled: false),
                        ],
                      ),
                      MediumText(text: "Yeni ev sahibinize biraz kendinizden bahsedin.",top: 40,bottom: 3,),
                      SmallText(text: "Örn; Taşınma nedenim şudur...",bottom: 18,),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xFFEDE8E9)),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: TextField(
                          maxLines: 6,
                          cursorColor: const Color(0xFF006DFF),
                          controller: _descriptionController,
                          maxLength: 300,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            counter: Text("${_descriptionController.text.length.toString()}/300"),
                            hintText: "Merhaba, ben ailem ile beraber İstanbul'dan iş için İzmir/Karşıyaka'ya taşınıyorum. Evinizin konumu ofisime çok yakın.",hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13)),
                        ),
                      ),
                      SmallText(text: "19.11.2022 tarihinde güncellendi.",top: 10,size: 11,bottom: 20,),
                      GestureDetector(
                        onTap: () async {
                          nullCheck();
                          if(_nullCheck == true){
                            try{
                            msg(context,"Kayıt Yükleniyor...",color: Colors.green,close: true);
                            await createAnimal(gender: gender, petFriend: petFriend == true ?  petFriendCount : "Yok", education: eduResult, salary: _salary.text, incomeType: addIncome ? incomeResult : "Yok", rentAmount: _rentAmount.text, minAmount: _values.start.toInt().toString(), maxAmount: _values.end.toInt().toString(), description: _descriptionController.text,selectedFile: _selectedFile);
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            Navigator.pushNamed(context, '/');
                            }
                            catch(e){
                              msg(context,"Kayıt Başarısız. Daha Sonra Tekrar Deneyiniz!",color: Colors.red);
                            }
                          }
                          
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF006DFF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical:15,horizontal: 55),
                          child: SmallText(text: "Kaydet",color: Colors.white,height: 1.75,),
                        ),
                      ),
                     ],
                   ),
                 ),
               ],
             ),
           ),
        ),
      ),
    );
  }

  void nullCheck(){
    if(eduResult == null) {
      msg(context,"Eğitim Durumunu Boş Bırakmayınız!");
    }
    else if(_salary.text== ""){
      msg(context,"Aylık Net Maaş Miktarını Boş Bırakmayınız!");
    }
    else if(incomeResult == null && addIncome==true){
      msg(context,"Gelir Tipini Boş Bırakmayınız!");

    }
    else if(_rentAmount.text == ""){
      msg(context,"Mevcut Kira Miktarını Boş Bırakmayınız!");
    }
    else if(_descriptionController.text == ""){
     msg(context,"Açıklama Alanını Boş Bırakmayınız!");
    }
    else
    {
     _nullCheck=true;
    }

  }



  void _choosePhoto(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            title: const Text("Galeriden Fotoğraf Seç"),
            onTap: () {
              _photoLoad(ImageSource.gallery);
            },
          ),
          ListTile(
            title: const Text("Kameradan Fotoğraf Seç"),
            onTap: () {
              _photoLoad(ImageSource.camera);
            },
          ),
        ]),
      ),
    );
  }

  void _photoLoad(ImageSource source) async {
    final picker = ImagePicker();
    final secilen = await picker.pickImage(source: source);
    setState(() {
      if (secilen != null) {
        _selectedFile = File(secilen.path);
      }
    });
    Navigator.pop(context);
  }


 _buildList({isColumn,list,deger}){
  String? value;
  late bool karsilastirma;
  return SizedBox(
      height: isColumn ? list.length * 50.0 + list.length * 10.0 : 50.0,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: isColumn ? Axis.vertical : Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
            if(deger == "gender"){
              karsilastirma = deger == "gender" && gender == list[index];
            }
            else if(deger == "petFriend"){
              karsilastirma = deger == "petFriend" && petFriend == list[index];
              list[index] == true ? value="Evet" : value="Hayır";
            }
            else if(deger=="petFriendCount"){
              karsilastirma = deger == "petFriendCount" && petFriendCount == list[index];
            }
            else if(deger=="addIncome"){
              karsilastirma = deger == "addIncome" && addIncome == list[index];
              list[index] == true ? value="Evet" : value="Hayır";
            }
          return GestureDetector(
            onTap: () {
              setState(() {
                if(deger=="gender") gender = list[index];
                else if(deger=="petFriend"){petFriend = list[index];}
                else if(deger=="addIncome"){addIncome = list[index];}
                else  petFriendCount = list[index];
              });
            },
            child: Container(
                height: 50,
                width:isColumn ? MediaQuery.of(context).size.width : (MediaQuery.of(context).size.width-40)/2-8,
                margin: EdgeInsets.only(right:isColumn != true && index + 1 !=list.length? 16: 0,bottom:isColumn ? 10 : 0),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                    color: karsilastirma
                        ? const Color(0xFF006DFF).withOpacity(0.25)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1,
                        color: karsilastirma
                            ? Color(0xFF006AFF)
                            : const Color(0xFFEDE8E9))),
                child: SmallText(text: value ?? list[index].toString(),textAlign: TextAlign.center,height: 1.313,color: karsilastirma ? Color(0xFF006AFF) : const Color(0xFF908E8E),)),
          );
        },
      ),
    );
  }

  var result;
  _buildSelectionPage({text,route,icon,width,enabled,resultValue,controller,keyboard}){
    icon.runtimeType == IconData ? icon = Icon(icon,color: Color(0xFF908E8E)) : icon= MediumText(text: icon,color: Color(0xFF908E8E));
    return GestureDetector(
      onTap: () async {
        if(route !=null){
          result = await Navigator.push(context,MaterialPageRoute(builder: (context) => route));          
        }
        setState(() {
          resultValue=="edu" ? eduResult = result : incomeResult = result;
        });
      },
      child: Container(
        width:width,
        padding: EdgeInsets.symmetric(horizontal: 15 ),
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: Color(0xFFEDE8E9)),
          borderRadius: BorderRadius.circular(8),
        ),
        child:TextField(
          keyboardType:keyboard,
          controller: controller,
          enabled: enabled,
          cursorColor: Color(0xFF006DFF),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            suffixIcon: icon,
            suffixIconConstraints: BoxConstraints(),
            hintText: resultValue == "edu" ? eduResult ?? text : resultValue=="income" ? incomeResult ?? text : text,
          ),
        ),
      ),
    );
  }
}
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:guvenlekirala/core/firebase/user_add_firebase.dart';
FirebaseStorage _storage = FirebaseStorage.instance;
Future createAnimal({
  File? selectedFile,
  required String gender,
  required String petFriend,
  required String education,
  required String salary,
  required String incomeType,
  required String rentAmount,
  required String minAmount,
  required String maxAmount,
  required String description,
}) async {
 
  final docUser = FirebaseFirestore.instance.collection('users').doc();
  String fileName = docUser.id;
  if (selectedFile != null) {
    File file = File(selectedFile.path);
    final user = UserAddFirebase(gender: gender, petFriend: petFriend, education: education, salary: salary, incomeType: incomeType, rentAmount: rentAmount, minAmount: minAmount, maxAmount: maxAmount, description: description);
    TaskSnapshot yukleme = await _storage
        .ref('users/$fileName.jpg')
        .putFile(file);
    String dosyaBaglantisi = await yukleme.ref.getDownloadURL();
    user.image = dosyaBaglantisi;
    await docUser.set(user.toJson());
  } else {
    final user = UserAddFirebase(gender: gender, petFriend: petFriend, education: education, salary: salary, incomeType: incomeType, rentAmount: rentAmount, minAmount: minAmount, maxAmount: maxAmount, description: description);
    await docUser.set(user.toJson());
  } 
}


Future<List<UserAddFirebase>> readAllUsers() async {
  final users = await FirebaseFirestore.instance.collection('users').get();
  return users.docs.map((doc) => UserAddFirebase.fromJson(doc)).toList();
}
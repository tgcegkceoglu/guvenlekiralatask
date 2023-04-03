import 'package:cloud_firestore/cloud_firestore.dart';

class UserAddFirebase{
  final String gender;
  final String petFriend;
  final String education;
  final String salary;
  final String incomeType;
  final String rentAmount;
  final String minAmount;
  final String maxAmount;
  final String description;
  String? image;

  UserAddFirebase({
    required this.gender,
    required this.petFriend,
    required this.education,
    required this.salary,
    required this.incomeType,
    required this.rentAmount,
    required this.minAmount,
    required this.maxAmount,
    required this.description,
    this.image,
  });
  Map<String, dynamic> toJson() => {
        'gender': gender,
        'petFriend':petFriend,
        'education': education,
        'salary': salary,
        'incomeType': incomeType,
        'rentAmount': rentAmount,
        'minAmount': minAmount,
        'maxAmount': maxAmount,
        'description': description,
        'image': this.image,
      };

  static UserAddFirebase fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) => 
      UserAddFirebase(
        gender: json['gender'],
        petFriend: json['petFriend'],
        education: json['education'],
        salary: json['salary'],
        incomeType: json['incomeType'],
        rentAmount: json['rentAmount'],
        minAmount: json['minAmount'],
        maxAmount: json['maxAmount'],
        description: json['description'],
        image: json['image'],
      );
}

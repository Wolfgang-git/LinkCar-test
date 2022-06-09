import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  bool? isVerified;
  final String? email;
  final String? password;
  final String? name;
  final String? lastName;
  final String? mobile;
  final int? birth;
  UserModel({this.uid, this.email, this.password, this.name, this.lastName, this.mobile, this.birth, this.isVerified});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastName': lastName,
      'mobile': mobile,
      'birth': birth,
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        email = doc.data()!["email"],
        name = doc.data()!["name"],
        lastName = doc.data()!["lastName"],
        mobile = doc.data()!["mobile"],
        birth = doc.data()!["birth"],
        password = null;

  UserModel copyWith({
    bool? isVerified,
    String? uid,
    String? email,
    String? name,
    String? lastName,
    String? mobile,
    int? birth,
  }) {
    return UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        mobile: mobile ?? this.mobile,
        birth: birth ?? this.birth,
        isVerified: isVerified ?? this.isVerified
    );
  }
}
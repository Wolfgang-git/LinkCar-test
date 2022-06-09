import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkcar/services/auth_service.dart';

import 'models/user_model.dart';

class DatabaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  addUserData(UserModel userData) async {
    await db.collection("Users").doc(userData.uid).set(userData.toMap());
  }

  Future<UserModel> retrieveUserData(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await db.collection("Users").doc(uid).get();
    return UserModel.fromDocumentSnapshot(snapshot);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkcar/services/database_service.dart';

import 'models/user_model.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseService db = DatabaseService();

  Stream<UserModel?> retrieveCurrentUserChanges() {
    return auth.userChanges().map((User? userData) {
      print(userData);
      return userData != null ? UserModel(
        uid: userData.uid,
        email: userData.email,
        isVerified: userData.emailVerified
      ) : null;
    });
  }

  Future<UserModel?> signUp(UserModel user) async {
    UserModel? userData;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!
      );
      userData = UserModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email,
        isVerified: userCredential.user!.emailVerified
      );
      verifyEmail();
      await db.addUserData(userData);
      return userData;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<UserModel?> signIn(UserModel user) async {
    print("signIn");
    UserModel? userData;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: user.email!,
          password: user.password!
      );
      userData = UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email,
          isVerified: userCredential.user!.emailVerified
      );
      var temp = await db.retrieveUserData(userData.uid!);
      userData.copyWith(
        name: temp.name,
        lastName: temp.lastName,
        birth: temp.birth
      );
      return userData;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<void> verifyEmail() async {
    User? user = auth.currentUser;
    if (user != null && !user.emailVerified) {
      return await user.sendEmailVerification();
    }
  }

  Future<void> changeEmail(String email) async {
    User? user = auth.currentUser;
    if (user != null) {
      user.updateEmail(email);
    }
  }

  Future<void> signOut() async {
    return await auth.signOut();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkcar/screens/profile/profile_screen.dart';
import 'package:linkcar/services/auth_service.dart';
import 'package:linkcar/services/database_service.dart';
import 'package:linkcar/services/models/user_model.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  AuthenticationService auth = AuthenticationService();
  DatabaseService db = DatabaseService();
  UserModel user = UserModel(email: "remi.balbous.games@gmail.com", password: "password");

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LinkCar',
      home: StreamBuilder<UserModel?>(
        stream: auth.retrieveCurrentUserChanges(),
        builder: (context, snapshot) {
            return FutureBuilder<UserModel>(
              future: snapshot.hasData ? getCurrentUserDataFromDB(snapshot.data!):  signInOrSignUpUser(),
              builder: (context, snapshot) {
                return snapshot.hasData ? StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: retrieveCurrentUserDBChanges(),
                  builder: (context, snapshotDB) {
                    if (snapshotDB.hasData) {
                      UserModel temp = UserModel.fromDocumentSnapshot(snapshotDB.data!);
                      return ProfileScreen(user: snapshot.data!.copyWith(
                        name: temp.name,
                        lastName: temp.lastName,
                      ));
                    } return const Center(child: CircularProgressIndicator());
                  }
                ) : const Center(child: CircularProgressIndicator());
                }
            );
        }
      )
    );
  }

  Future<UserModel> getCurrentUserDataFromDB(UserModel userData) async {
    UserModel userDataFromDB = await db.retrieveUserData(userData.uid!);
    user = userDataFromDB.copyWith(
      email: userData.email,
      isVerified: userData.isVerified,
      name: userDataFromDB.name,
      lastName: userDataFromDB.lastName,
      mobile: userDataFromDB.mobile,
      birth: userDataFromDB.birth
    );
    return user;
  }

  Future<UserModel> signInOrSignUpUser() async {
    try {
      UserModel? userData = await auth.signIn(user);
      return await getCurrentUserDataFromDB(userData!);
    } catch (e) {
      UserModel? userData = await auth.signUp(user);
      user = user.copyWith(
        uid: userData?.uid,
        email: userData?.email,
        isVerified: userData?.isVerified,
      );
    }
    return user;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> retrieveCurrentUserDBChanges() {
    return db.db.collection("Users").doc(user.uid).snapshots();
  }
}

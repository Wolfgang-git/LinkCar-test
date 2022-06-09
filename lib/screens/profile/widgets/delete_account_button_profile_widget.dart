import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkcar/assets/colors.dart';
import 'package:linkcar/assets/strings.dart';
import 'package:linkcar/services/auth_service.dart';
import 'package:linkcar/services/database_service.dart';

import '../../../bloc/buttons/edit_button_profile_bloc.dart';
import '../../../services/models/user_model.dart';

class DeleteAccountButtonProfileWidget extends StatelessWidget {
  bool temp = false;
  final UserModel user;
  DeleteAccountButtonProfileWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
            onPressed: () {
              DatabaseService().db.collection("Users").doc(user.uid).delete();
              AuthenticationService().auth.currentUser?.delete();
              exit(0);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisSize: MainAxisSize.min, children: const [
                Text("Delete Account",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(LinkCarColors.red)),
                ),
                SizedBox(width: 8.0),
              ])
            )
    );
  }
}

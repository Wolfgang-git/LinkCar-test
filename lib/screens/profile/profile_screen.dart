import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkcar/bloc/buttons/edit_button_profile_bloc.dart';
import 'package:linkcar/screens/profile/widgets/delete_account_button_profile_widget.dart';
import 'package:linkcar/screens/profile/widgets/edit_button_profile_widget.dart';
import 'package:linkcar/screens/profile/widgets/sign_out_button_profile_widget.dart';
import 'package:linkcar/screens/profile/widgets/user_info_profile_widget.dart';
import 'package:linkcar/screens/profile/widgets/user_card_profile_widget.dart';
import 'package:linkcar/screens/shared/widgets/title_screen_shared_widget.dart';
import '../../services/models/user_model.dart';


class ProfileScreen extends StatelessWidget {
  final UserModel user;
  bool isEditMode = false;

  ProfileScreen({Key? key, required this.user}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (context) => EditButtonProfileBloc(),
          child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(alignment: Alignment.topRight, child: EditButtonProfileWidget(user: user)),
                  const TitleScreenSharedWidget(title: "Profile"),
                  UserCardProfileWidget(displayName: "${user.name ?? ""} ${user.lastName ?? ""}", isVerified: user.isVerified!), // User Card
                  UserInfoProfileWidget(user: user),
                  Align(alignment: Alignment.center, child: SignOutButtonProfileWidget(user: user)),
                  const SizedBox(height: 16.0),
                  Align(alignment: Alignment.center, child: DeleteAccountButtonProfileWidget(user: user)),
                ],
              )
          ),
        )
    );
  }
}
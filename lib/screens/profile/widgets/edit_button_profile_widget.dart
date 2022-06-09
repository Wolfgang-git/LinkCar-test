import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkcar/assets/colors.dart';
import 'package:linkcar/assets/strings.dart';

import '../../../bloc/buttons/edit_button_profile_bloc.dart';
import '../../../services/models/user_model.dart';

class EditButtonProfileWidget extends StatelessWidget {
  bool temp = false;
  final UserModel user;
  EditButtonProfileWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditButtonProfileBloc, EditButtonProfileState>(
      builder: (context, state) {
        state as EditButtonProfileValidate;
        if (temp == !state.isEditMode && state.isEditMode == false) {
          context.read<EditButtonProfileBloc>().add(SubmitEvent(user: user));
        }
        temp = state.isEditMode;

        return TextButton(
            onPressed: () {
              context.read<EditButtonProfileBloc>().add(EditButtonProfilePressedEvent());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  (state.isEditMode) ? Strings.saveButtonProfileScreen : Strings.editButtonProfileScreen,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(LinkCarColors.blue)),
                ),
                const SizedBox(width: 8.0),
                Container(
                    child: (state.isEditMode) ? null
                        : const FaIcon(
                            FontAwesomeIcons.pen,
                            color: Color(LinkCarColors.blue),
                            size: 15,
                          ))
              ]),
            ));
      },
    );
  }
}

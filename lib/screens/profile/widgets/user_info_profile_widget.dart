import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkcar/services/models/user_model.dart';
import '../../../assets/colors.dart';
import '../../../assets/strings.dart';
import '../../../bloc/buttons/edit_button_profile_bloc.dart';

class UserInfoProfileWidget extends StatefulWidget {
  final UserModel user;

  const UserInfoProfileWidget({ Key? key, required this.user}) : super(key: key);

  @override
  _UserInfoProfileWidgetState createState() => _UserInfoProfileWidgetState();
}

class _UserInfoProfileWidgetState extends State<UserInfoProfileWidget> {

  var controllerEmail;
  var controllerName;
  var controllerLastName;
  var controllerMobile;

  @override
  void initState() {
    controllerEmail = TextEditingController(text: widget.user.email);
    context.read<EditButtonProfileBloc>().add(EmailChanged(email: controllerEmail.text));
    controllerName = TextEditingController(text: !(widget.user.name == null || widget.user.name == "") ? widget.user.name : "-");
    context.read<EditButtonProfileBloc>().add(NameChanged(name: controllerName.text));
    controllerLastName = TextEditingController(text: !(widget.user.lastName == null || widget.user.lastName == "") ? widget.user.lastName : "-");
    context.read<EditButtonProfileBloc>().add(LastNameChanged(lastName: controllerLastName.text));
    controllerMobile = TextEditingController(text: !(widget.user.mobile == null  || widget.user.mobile == "") ? widget.user.mobile : "-");
    super.initState();
  }


  @override
  void dispose() {
    controllerEmail.dispose();
    controllerName.dispose();
    controllerLastName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditButtonProfileBloc, EditButtonProfileState>(
      builder: (context, state) {
        state as EditButtonProfileValidate;
        return Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              children: [
                Row(
                    children: [
                      Expanded(child: TextFormField(
                            onChanged: (value) => context.read<EditButtonProfileBloc>().add(NameChanged(name: value)),
                            enabled: state.isEditMode,
                            controller: controllerName,
                            decoration: myInputDecoration(Strings.labelNameTextFieldProfileScreen,
                                const UnderlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15))),
                                !state.isNameValid ? "Name is invalid" : null),
                          ),
                        ),
                      // Name
                      SizedBox(width: state.isEditMode ? 8.0 : 4.0),
                      Expanded(child: TextFormField(
                            onChanged: (value) => context.read<EditButtonProfileBloc>().add(LastNameChanged(lastName: value)),
                            enabled: state.isEditMode,
                            controller: controllerLastName,
                            decoration: myInputDecoration(Strings.labelLastNameTextFieldProfileScreen,
                                  const UnderlineInputBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15))),
                                !state.isLastNameValid ? "Last name is invalid" : null)
                          ),
                        ),// Last Name
                    ]
                ),
                SizedBox(height: state.isEditMode ? 8.0 : 4.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                            onChanged: (value) => context.read<EditButtonProfileBloc>().add(EmailChanged(email: value)),
                            controller: controllerEmail,
                            enabled: state.isEditMode,
                            decoration: myInputDecoration(Strings.labelEmailTextFieldProfileScreen, null,
                              !state.isEmailValid ? "Please enter an email valid" : null)
                          ),
                        ),
                  ],
                ), // Email
                SizedBox(height: state.isEditMode ? 8.0 : 4.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                              enabled: state.isEditMode,
                              controller: controllerMobile,
                              decoration: myInputDecoration(Strings.labelMobileTextFieldProfileScreen, null, null)
                          ),
                        ),
                  ],
                ), // Mobile
                SizedBox(height: state.isEditMode ? 8.0 : 4.0),
                Row(
                  children: [
                    Expanded(child: TextFormField(
                        enabled: state.isEditMode,
                        controller: TextEditingController(text: "-"),
                        decoration: myInputDecoration(Strings.labelBirthTextFieldProfileScreen,
                            const UnderlineInputBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))), null)
                    )), // Birth
                    SizedBox(width: state.isEditMode ? 8.0 : 4.0),
                    Expanded(child: TextFormField(
                        enabled: state.isEditMode,
                        controller: TextEditingController(text: "-"),
                        decoration: myInputDecoration(Strings.labelBirthLocationTextFieldProfileScreen,
                            const UnderlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(15))), null)
                    )) // Birth Location
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

InputDecoration myInputDecoration(label, border, errorMessage) {
  return InputDecoration(
    filled: true,
    errorText: errorMessage,
    errorStyle: const TextStyle(color: Color(LinkCarColors.red)),
    labelText: label,
    labelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(LinkCarColors.blue)
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color(LinkCarColors.blue).withOpacity(0.04), width: 1.5),
        borderRadius: const BorderRadius.all(Radius.circular(15.0))
    ),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(LinkCarColors.blue), width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(15.0))
    ),
    border: border,
  );
}

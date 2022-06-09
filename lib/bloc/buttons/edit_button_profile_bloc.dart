import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:linkcar/services/auth_service.dart';
import 'package:linkcar/services/database_service.dart';
import 'package:linkcar/services/models/user_model.dart';

part 'edit_button_profile_event.dart';
part 'edit_button_profile_state.dart';

class EditButtonProfileBloc extends Bloc<EditButtonProfileEvent, EditButtonProfileValidate> {
  EditButtonProfileBloc() : super(const EditButtonProfileValidate(
    isEditMode: false,
    email: "",
    name: "",
    lastName: "",
    isEmailValid: false,
    isNameValid: false,
    isLastNameValid: false,
  )) {

    on<EditButtonProfilePressedEvent>(onEditButtonProfilePressedEvent);
    on<EmailChanged>(onEmailChanged);
    on<NameChanged>(onNameChanged);
    on<LastNameChanged>(onLastNameChanged);
    on<SubmitEvent>(onSubmitEvent);
  }
  onEditButtonProfilePressedEvent(EditButtonProfilePressedEvent event, Emitter<EditButtonProfileState> emit) {
      emit(state.copyWith(
        isEditMode: !state.isEditMode
      ));
  }
  final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$",
  );

  bool isEmailValid(String email) {
      bool isEmailValid = _emailRegExp.hasMatch(email);
      return isEmailValid;
  }

  bool isNameValid(String name) {
    bool isNameValid = name.isNotEmpty;
    return isNameValid;
  }
  bool isLastNameValid(String lastName) {
    bool isNameValid = lastName.isNotEmpty;
    return isNameValid;
  }

  onEmailChanged(EmailChanged event, Emitter<EditButtonProfileState> emit) {
    emit(state.copyWith(
      email: event.email,
      isEmailValid: isEmailValid(event.email)
    ));
  }

  onNameChanged(NameChanged event, Emitter<EditButtonProfileState> emit) {
    emit(state.copyWith(
      name : event.name,
      isNameValid: isNameValid(event.name)
    ));
  }

  onLastNameChanged(LastNameChanged event, Emitter<EditButtonProfileState> emit) {
    emit(state.copyWith(
      lastName : event.lastName,
      isLastNameValid: isLastNameValid(event.lastName)
    ));
  }

  onSubmitEvent(SubmitEvent event, Emitter<EditButtonProfileState> emit) async {
    if (state.isEmailValid && state.isNameValid && state.isLastNameValid) {
      if (event.user.email != state.email) {
        AuthenticationService().auth.currentUser?.updateEmail(state.email);
      }
      DatabaseService databaseService = DatabaseService();
      await databaseService.addUserData(event.user.copyWith(
          name: state.name,
          lastName: state.lastName));
    }
      emit(state);
    }
  }
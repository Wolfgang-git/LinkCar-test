part of 'edit_button_profile_bloc.dart';

abstract class EditButtonProfileState extends Equatable {
  const EditButtonProfileState();
}

class EditButtonProfileInitial extends EditButtonProfileState {
  @override
  List<Object> get props => [];
}

class EditButtonProfileValidate extends EditButtonProfileState {
  final bool isEditMode;
  final String email;
  final String name;
  final String lastName;
  final bool isEmailValid;
  final bool isNameValid;
  final bool isLastNameValid;

  const EditButtonProfileValidate({
    required this.isEditMode,
    required this.email,
    required this.name,
    required this.lastName,
    required this.isEmailValid,
    required this.isNameValid,
    required this.isLastNameValid,
  });

  EditButtonProfileValidate copyWith({
    bool? isEditMode,
    String? email,
    String? name,
    String? lastName,
    bool? isEmailValid,
    bool? isNameValid,
    bool? isLastNameValid,
  }) {
    return EditButtonProfileValidate(
      isEditMode: isEditMode ?? this.isEditMode,
      email: email ?? this.email,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isNameValid: isNameValid ?? this.isNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
    );
  }

  @override
  List<Object?> get props => [isEditMode, email, name, lastName, isEmailValid];
}
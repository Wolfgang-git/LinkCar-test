part of 'edit_button_profile_bloc.dart';

abstract class EditButtonProfileEvent extends Equatable {
  const EditButtonProfileEvent();

  @override
  List<Object> get props => [];
}

class EditButtonProfilePressedEvent extends EditButtonProfileEvent {}

class EmailChanged extends EditButtonProfileEvent {
  final String email;
  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class NameChanged extends EditButtonProfileEvent {
  final String name;
  const NameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class LastNameChanged extends EditButtonProfileEvent {
  final String lastName;
  const LastNameChanged({required this.lastName});

  @override
  List<Object> get props => [lastName];
}

class SubmitEvent extends EditButtonProfileEvent {
  final UserModel user;
  const SubmitEvent({required this.user});

  @override
  List<Object> get props => [user];
}
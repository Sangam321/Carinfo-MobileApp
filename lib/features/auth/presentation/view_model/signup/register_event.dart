part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesAndBatches extends RegisterEvent {}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String fName;

  final String email;
  final String password;
  final String confirmPassword;

  const RegisterUser({
    required this.context,
    required this.fName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

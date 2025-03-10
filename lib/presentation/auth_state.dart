import 'package:flutter/material.dart';
import 'package:state_management_project_flutter/users/user_entity.dart';

class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final User user;
  Authenticated(this.user);
}

class Unauthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthLogout extends AuthState {}

class AuthLogin extends AuthState {}

class AuthEmailValid extends AuthState {

  final String email;
  final VoidCallback? nextStep;
  AuthEmailValid(this.email,this.nextStep);
}

class AuthPasswordsMatch extends AuthState {
  
  final VoidCallback? nextStep;
  AuthPasswordsMatch(this.nextStep);
}

class AuthPasswordsDoNotMatch extends AuthState {
  
  final String? errorMessage;
  AuthPasswordsDoNotMatch(this.errorMessage);
}

class AuthPasswordValid extends AuthState {
  final String password;
  final VoidCallback? nextStep;
  AuthPasswordValid(this.password,this.nextStep);
}
class AuthNameValid extends AuthState{
  final String name;
  final VoidCallback? nextStep;
  AuthNameValid(this.name,this.nextStep);
}
class AuthEmailInvalid extends AuthState {
  final String? errorMessage;
  AuthEmailInvalid(this.errorMessage);
}

class AuthPasswordInvalid extends AuthState {
  final String? errorMessage;
  AuthPasswordInvalid(this.errorMessage);
}

class AuthLoginSuccess extends AuthState {}

class AuthSignUpSuccess extends AuthState {}

class AuthSignUpFailure extends AuthState {}

class AuthSignUpInProgress extends AuthState {}

class AuthSignUpInitial extends AuthState {}

class AuthSignUpStepEmail extends AuthState {}
class AuthSignUpStepName extends AuthState {}
class AuthSignUpStepPic extends AuthState { }
class AuthSignUpStepPassword extends AuthState {}
class AuthSignUpStepPasswordConfirm extends AuthState {}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_project_flutter/auth_requirements/auth_variables_and_funcitons.dart';
import 'package:state_management_project_flutter/presentation/auth_state.dart';

class SignInCubit extends Cubit<AuthState> implements SignInVariablesAndFuncitons {
  SignInCubit(super.initialState);

  @override
  void onEmailChanged(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (emailRegex.hasMatch(email)) {
      emit(AuthEmailInvalid());
    } else {
      emit(AuthEmailInvalid());
    }
  }

  @override
  void onPasswordChanged(String password) {
    if (password.length < 6) {
      emit(AuthPasswordInvalid());
    } else {
      emit(AuthPasswordValid(passw));
    }
  }

  @override
  void onSignIn() async {
    if (email == null || password == null) {
      emit(AuthError('Email and password must not be empty'));
    } else {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(AuthLoginSuccess());
    }
  }

  @override
  String? email;

  @override
  String? password;
  
  
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_project_flutter/auth_requirements/auth_variables_and_funcitons.dart';
import 'package:state_management_project_flutter/presentation/auth_state.dart';

class SignUpCubit extends Cubit<AuthState>
    implements SignUpVariablesAndFunctions {
  SignUpCubit(super.initialState);

  @override
  String? email;

  @override
  String? password;

  @override
  bool? passwordVerified;

  String? _secondPassword;

  @override
  void onEmailChanged(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (emailRegex.hasMatch(email)) {
      this.email = email;
      emit(AuthEmailValid(email,nextStep));
    } else {
      this.email = null;
      emit(AuthEmailInvalid('Email is invalid'));
    }
  }

  @override
  void onPasswordChanged(String password) {
    if (password.length < 6) {
      this.password = null;
      passwordVerified = false;
      emit(AuthPasswordInvalid('Password must be at least 6 characters'));
    } else {
      this.password = password;
      passwordVerified = false;
      emit(AuthPasswordValid(password,nextStep));
    }
  }

  @override
  void onPasswordsMatch(String secondPassword) {
    _secondPassword = secondPassword;
    if (password == _secondPassword) {
      passwordVerified = true;
      emit(AuthPasswordsMatch(nextStep));
    } else {
      passwordVerified = false;
      emit(AuthPasswordsDoNotMatch('Passwords do not match'));
    }
  }

  @override
  void onSignUp() async {
    if (email == null || password == null || passwordVerified != true) {
      emit(AuthError(
          'Email and passwords must not be empty and passwords must match'));
    } else {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(AuthSignUpSuccess());
    }
  }

  @override
  void nextStep() {
    if (state is AuthEmailValid){
      emit(AuthSignUpStepPassword());
    }
    if (state is AuthPasswordValid){
      emit(AuthSignUpStepPasswordConfirm());
    }
    if (state is AuthPasswordsMatch){
      emit(AuthSignUpStepName());
    }
    // TODO: implement nextStep
  }

  @override
  SignUpStep? signUpStep = SignUpStep.email;
}

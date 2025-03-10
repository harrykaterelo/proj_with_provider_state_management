import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:state_management_project_flutter/auth_requirements/auth_variables_and_funcitons.dart';


import 'auth_state.dart';

abstract class SignUpFormFormat extends StatelessWidget {
  final Function(String)? onEmailChanged;
  final Function(String)? onPasswordChanged;
  final Function(String)? onPasswordConfirmChanged;
  final AuthState? state;

  
  
  final XFile? selectedPic;
  final SignUpStep? step;
  
  
  final VoidCallback? previousPage;

  const SignUpFormFormat(
      {super.key,
     
      this.step,
      
      this.selectedPic,
      this.onPasswordConfirmChanged,
      this.onEmailChanged,
      this.onPasswordChanged,
      
      this.previousPage,
      this.state});

      
  bool? get emailValid => state is AuthEmailValid
      ? true
      : (state is AuthEmailInvalid ? false : null);
  bool? get passwordValid => state is AuthPasswordValid?true:(state is AuthPasswordInvalid?false:null);
  bool? get passwordsMatch => state is AuthPasswordsMatch?true:(state is AuthPasswordsDoNotMatch?false:null);
  bool? get formInProgress => state is AuthSignUpInProgress;
  @override
  Widget build(BuildContext context);

  SignUpFormFormat copyWith(
      {AuthState? state,
      Function(String)? onEmailChanged,
      Function(String)? onPasswordChanged,
      Function(String)? onPasswordConfirmChanged,
     
      XFile? selectedPic,
      SignUpStep? step,
      VoidCallback? previousPage});
}

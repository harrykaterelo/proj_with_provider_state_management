import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_project_flutter/auth_requirements/auth_variables_and_funcitons.dart';
import 'package:state_management_project_flutter/presentation/auth_state.dart';
import 'package:state_management_project_flutter/bloc/sign_up_cubit.dart';
import 'package:state_management_project_flutter/presentation/sign_up_form.dart';

class SignUpWrapper extends StatelessWidget {
  final SignUpFormFormat widget;
  const SignUpWrapper({super.key, required this.widget});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        create: (context) => SignUpCubit(AuthSignUpInitial()),
        child: _Signupwrapper(
          widget: widget,
        ));
  }
}

class _Signupwrapper extends StatelessWidget {
  final SignUpFormFormat widget;

  const _Signupwrapper({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, AuthState>(
        builder: (context, state) {
          
          
          

          return widget.copyWith(
              onEmailChanged: context.read<SignUpCubit>().onEmailChanged,
              onPasswordChanged: context.read<SignUpCubit>().onPasswordChanged,
              
              state: state,
              onPasswordConfirmChanged:
                  context.read<SignUpCubit>().onPasswordsMatch,
              
              
              selectedPic: null,
              
              
              );
        },
        listener: (context, state) => {});
  }
}

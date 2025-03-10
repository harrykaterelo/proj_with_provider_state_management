import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:state_management_project_flutter/auth_requirements/auth_variables_and_funcitons.dart';

import 'package:state_management_project_flutter/presentation/sign_up_form.dart';
import 'package:state_management_project_flutter/widgets/pic_container.dart';
import 'package:state_management_project_flutter/widgets/sign_up_footer.dart';
import 'package:state_management_project_flutter/users/user_entity.dart';

import '../presentation/auth_state.dart';

class SignUpForm extends SignUpFormFormat {
  final AuthState? state;

  const SignUpForm({
    super.key,
    this.state,
    super.onEmailChanged,
    super.onPasswordChanged,
    super.onPasswordConfirmChanged,
    
    super.previousPage,
    super.selectedPic,
    super.step,
  });

  bool? get emailValid => state is AuthEmailValid
      ? true
      : (state is AuthEmailInvalid ? false : null);
  bool? get passwordValid => state is AuthPasswordValid?true:(state is AuthPasswordInvalid?false:null);
  bool? get passwordsMatch => state is AuthPasswordsMatch?true:(state is AuthPasswordsDoNotMatch?false:null);
  bool? get formInProgress => state is AuthSignUpInProgress;

  String titleFind() {
    switch (step) {
      case SignUpStep.email:
        return "Pass your email:";
      case SignUpStep.pic:
        return "Select a profile pic";
      case SignUpStep.name:
        return "Enter your name";
      case SignUpStep.password:
        return "Enter your password";
      case SignUpStep.passwordConfirm:
        return "Confirm your password";
      default:
        return "All Done!";
    }
  }

  Icon findIcon() {
    switch (step) {
      case SignUpStep.email:
        return Icon(CupertinoIcons.mail_solid, color: Colors.white, size: 15);
      case SignUpStep.name:
        return Icon(CupertinoIcons.person_alt, color: Colors.white, size: 15);
      case SignUpStep.password:
        return Icon(CupertinoIcons.padlock, color: Colors.white, size: 15);
      default:
        return Icon(CupertinoIcons.padlock_solid,
            color: Colors.white, size: 15);
    }
  }

  String findPlaceholderText() {
    switch (step) {
      case SignUpStep.email:
        return "We will verify it later...";
      case SignUpStep.name:
        return "It will be displayed in your profile...";
      case SignUpStep.password:
        return "Must use at least a capital, a number and a special character...";
      default:
        return "Must match your password exactly...";
    }
  }

  @override
  Widget build(BuildContext context) {
    late Function(String)? onChanged;
    String? errorText;
    bool? conditionForValidity;

    if (step == SignUpStep.email) {
      onChanged = onEmailChanged!;
      errorText = "This is not an email";
      conditionForValidity = !emailValid!;
    } else if (step == SignUpStep.password) {
      onChanged = onPasswordChanged!;
      errorText = "Must contain a capital, a number and a special character";
      conditionForValidity = !passwordValid!;
    } else if (step == SignUpStep.passwordConfirm) {
      onChanged = onPasswordConfirmChanged;
      errorText = "Passwords don't match";
      conditionForValidity = !passwordsMatch!;
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.deepPurple],
            stops: [0.4, 1],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 17, 0, 30),
              child: Text(
                "Your App Sign - Up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontFamily: "San Francisco",
                ),
              ),
            ),
            Row(
              children: [
                Spacer(),
                Column(
                  crossAxisAlignment: step == SignUpStep.finish
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5, left: 10),
                      child: Text(titleFind(),
                          style: TextStyle(
                            fontFamily: "San Francisco",
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontSize: 14,
                          )),
                    ),
                    step == SignUpStep.name ||
                            step == SignUpStep.password ||
                            step == SignUpStep.passwordConfirm ||
                            step == SignUpStep.email
                        ? Container(
                            width: 900,
                            height: 50,
                            child: TextField(
                              onChanged: onChanged,
                              obscureText: step == SignUpStep.password ||
                                  step == SignUpStep.passwordConfirm,
                              decoration: InputDecoration(
                                errorText: conditionForValidity == true
                                    ? errorText
                                    : null,
                                hintText: findPlaceholderText(),
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontStyle: FontStyle.italic,
                                  fontFamily: "San Francisco",
                                  fontSize: 15,
                                ),
                                prefixIcon: findIcon(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.deepOrange, width: 3),
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "San Francisco",
                              ),
                            ),
                          )
                        : PicContainer(pic: selectedPic),
                    if (conditionForValidity == false)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: nextPage,
                          child: Text("Next"),
                        ),
                      ),
                  ],
                ),
                Spacer(),
              ],
            ),
            Spacer(),
            SignUpFooter(step: step),
          ],
        ),
      ),
    );
  }

  @override
  SignUpFormFormat copyWith({
    AuthState? state,
    Function(String p1)? onEmailChanged,
    Function(String p1)? onPasswordChanged,
    Function(String p1)? onPasswordConfirmChanged,
    String? selectedEmail,
    String? selectedName,
    XFile? selectedPic,
    SignUpStep? step,
    VoidCallback? onSubmit,
    VoidCallback? nextPage,
    VoidCallback? previousPage,
  }) {
    return SignUpForm(
      state: state ?? this.state,
      onEmailChanged: onEmailChanged ?? this.onEmailChanged,
      onPasswordChanged: onPasswordChanged ?? this.onPasswordChanged,
      onPasswordConfirmChanged:
          onPasswordConfirmChanged ?? this.onPasswordConfirmChanged,
      selectedEmail: selectedEmail ?? this.selectedEmail,
      selectedName: selectedName ?? this.selectedName,
      selectedPic: selectedPic ?? this.selectedPic,
      step: step ?? this.step,
      onSubmit: onSubmit ?? this.onSubmit,
      nextPage: nextPage ?? this.nextPage,
      previousPage: previousPage ?? this.previousPage,
    );
  }
}

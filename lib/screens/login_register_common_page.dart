import 'package:flutter/material.dart';
import 'package:whatsappdemo/widgets/common_button.dart';
import 'package:whatsappdemo/widgets/common_textfield.dart';
import '../data/firestore_data.dart';
import '../widgets/logo_container.dart';

class LoginRegisterCommonScreen extends StatefulWidget {
  final bool textFieldEvent;
  const LoginRegisterCommonScreen({
    Key? key,
    required this.textFieldEvent,
  }) : super(key: key);

  @override
  State<LoginRegisterCommonScreen> createState() =>
      _LoginRegisterCommonScreenState();
}

String? userFormName, userFormEmail, userFormPassword, userFormConfirmPassword;

class _LoginRegisterCommonScreenState extends State<LoginRegisterCommonScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    // bool textFieldEvent = true;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LogoContainer(),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: widget.textFieldEvent == true
                  ? Text(
                      "Create a New Account",
                      style:
                          TextStyle(fontSize: 20, color: Colors.green.shade900),
                    )
                  : Text(
                      "Sign In Your Account",
                      style:
                          TextStyle(fontSize: 20, color: Colors.green.shade900),
                    ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  widget.textFieldEvent == true
                      ? CommonTextField(
                          labelName: 'Name',
                          obscureText: false,
                          onChange: (nameValue) {
                            userFormName = nameValue;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Name';
                            }
                            return null;
                          },
                        )
                      : const SizedBox(),
                  CommonTextField(
                    labelName: 'Email',
                    obscureText: false,
                    onChange: (emailValue) {
                      userFormEmail = emailValue;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),
                  CommonTextField(
                    labelName: 'Password',
                    obscureText: true,
                    onChange: (passwordValue) {
                      userFormPassword = passwordValue;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password';
                      }
                      return null;
                    },
                  ),
                  widget.textFieldEvent == true
                      ? CommonTextField(
                          labelName: 'ConfirmPassword',
                          obscureText: true,
                          onChange: (confirmPasswordValue) {
                            userFormConfirmPassword = confirmPasswordValue;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter ConfirmPassword';
                            }
                            return null;
                          },
                        )
                      : const SizedBox(),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, right: 30, left: 30),
                    child: widget.textFieldEvent == true
                        ? CommonButton(
                            buttonName: "Sign Up",
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('SignUp Sucessfull')),
                                );
                              }
                              await signUpUser(
                                context: context,
                                userName: userFormName!,
                                userEmail: userFormEmail!,
                                userPassword: userFormPassword!,
                              );
                            },
                          )
                        : CommonButton(
                            buttonName: "Sign In",
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('SignIn Sucessfully')),
                                );
                                await signInUser(
                                    context: context,
                                    email: userFormEmail!,
                                    password: userFormPassword!);
                              }
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

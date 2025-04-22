import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/auth/signup_controller.dart';
import 'package:notes_app/utils/auth/email_validator.dart';
import 'package:notes_app/utils/auth/password_validator.dart';
import 'package:notes_app/widgets/auth/button_login_signup_widget.dart';
import 'package:notes_app/widgets/auth/textformfield_widget.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Container(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/images/notes.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Using TextFormFieldWidget for each field
                TextFormFieldWidget(
                  label: "Username",
                  icon: Icons.person,
                  initialObscureText: false,
                  controller: signUpController.username,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your username";
                    }
                    return null;
                  },
                ),
                TextFormFieldWidget(
                  label: "Email",
                  initialObscureText: false,
                  icon: Icons.email,
                  controller: signUpController.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => EmailValidator.validate(value),
                ),

                TextFormFieldWidget(
                  label: "Phone Number",
                  initialObscureText: false,
                  icon: Icons.phone,
                  controller: signUpController.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your phone number";
                    }
                    if (value.length != 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                TextFormFieldWidget(
                  label: "Password",
                  icon: Icons.lock,
                  controller: signUpController.password,
                  initialObscureText: true,
                  validator: (value) => PasswordValidator.validate(value),
                ),
                const SizedBox(height: 30),
                Obx(() {
                  return signUpController.isLoading.value
                      ? const CircularProgressIndicator()
                      : ButtonLoginSignupWidget(
                        text: "Sign Up",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            signUpController.signUp();
                            Get.snackbar(
                              "Sign Up",
                              "Your account has been created.",
                            );
                          }
                        },
                      );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

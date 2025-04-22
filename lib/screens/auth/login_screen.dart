import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/auth/login_controller.dart';
import 'package:notes_app/screens/auth/passpword_screen.dart';
import 'package:notes_app/screens/auth/signup_screen.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/services/sttings_services.dart';
import 'package:notes_app/utils/auth/email_validator.dart';
import 'package:notes_app/utils/auth/password_validator.dart';
import 'package:notes_app/widgets/auth/button_login_signup_widget.dart';
import 'package:notes_app/widgets/auth/textbutton_login_signup_widget.dart';
import 'package:notes_app/widgets/auth/textformfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
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
                  TextFormFieldWidget(
                    label: "Email",
                    icon: Icons.email,
                    controller: loginController.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => EmailValidator.validate(value),
                  ),
                  TextFormFieldWidget(
                    label: "Password",
                    icon: Icons.lock,
                    controller: loginController.password,
                    initialObscureText: true,
                    validator: (value) => PasswordValidator.validate(value),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Şifre sıfırlama sayfasına yönlendirme
                            Get.to(
                              ChangePasswordScreen(),
                            ); // ResetPasswordScreen() yerine kendi ekranınızı kullanabilirsiniz
                          },
                          child: Text(
                            "Forget Password",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ButtonLoginSignupWidget(
                    text: "Login",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        bool isLoggedIn = await loginController.login();
                        if (isLoggedIn) {
                          await Get.find<SettingsServices>().sharedPreferences
                              .setString(
                                "role",
                                "0",
                              ); // Not: 'roul' yerine 'role' kullandım.
                          Get.offAll(HomeScreen());
                        } else {
                          Get.snackbar(
                            "Login Failed",
                            "Incorrect email or password",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      }
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      TextbuttonLoginSignupWidget(
                        title: "Sign up",
                        onPressed: () {
                          Get.off(SignUpScreen());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

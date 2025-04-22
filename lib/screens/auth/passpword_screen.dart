import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/utils/auth/conform_passpword_validator.dart';
import 'package:notes_app/utils/auth/password_validator.dart';
import 'package:notes_app/widgets/auth/button_login_signup_widget.dart';
import 'package:notes_app/widgets/auth/textbutton_login_signup_widget.dart';
import 'package:notes_app/widgets/auth/textformfield_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Please enter your current password and a new one.",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Current Password Field
                TextFormFieldWidget(
                  label: "Current Password",
                  icon: Icons.lock,
                  controller: _currentPasswordController,
                  initialObscureText: true,
                  validator: (value) => PasswordValidator.validate(value),
                ),
                const SizedBox(height: 20),

                // New Password Field
                TextFormFieldWidget(
                  label: "New Password",
                  icon: Icons.lock,
                  controller: _newPasswordController,
                  initialObscureText: true,
                  validator: (value) => PasswordValidator.validate(value),
                ),
                const SizedBox(height: 20),

                // Confirm New Password Field
                TextFormFieldWidget(
                  label: "Confirm New Password",
                  icon: Icons.lock,
                  controller: _confirmPasswordController,
                  initialObscureText: true,
                  validator:
                      (value) => ConfirmPasswordValidator.validate(
                        value,
                        _newPasswordController.text,
                      ),
                ),
                const SizedBox(height: 30),

                // Submit Button
                ButtonLoginSignupWidget(
                  text: "ChangePassword",
                  onPressed: () {},
                ),

                const SizedBox(height: 20),

                // Back Button
                TextbuttonLoginSignupWidget(
                  title: "Back to Profile",
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

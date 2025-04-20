class ConfirmPasswordValidator {
  static String? validate(String? value, String? newPassword) {
    if (value == null || value.isEmpty) {
      return "Please confirm your new password";
    }

    if (value != newPassword) {
      return "Passwords do not match";
    }

    return null; // Geçerli
  }
}

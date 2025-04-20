class EmailValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    // Basit bir e-posta doğrulama regex'i
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }

    return null; // geçerli
  }
}

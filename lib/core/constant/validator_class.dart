class ValidatorClass {
  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    // يقبل رقم يبدأ بـ + (اختياري) ويتبعه من 7 إلى 15 رقم
    final phoneRegExp = RegExp(r'^\+?[0-9]{7,15}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    return null; // valid
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email';
    }

    return null; // valid
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null; // valid
  }

  String? fullNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null; // valid
  }
}

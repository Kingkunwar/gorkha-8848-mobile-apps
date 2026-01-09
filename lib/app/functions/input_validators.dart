class InputValidators {
  static String? requiredValidator(String? val) {
    if (val != null && val.trim().isNotEmpty) {
      return null;
    } else {
      return "*Required.";
    }
  }

  static String? emailValidator(String? val) {
    if (val != null &&
        val.trim().isNotEmpty &&
        RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(val)) {
      return null;
    } else {
      return "Please enter a valid email.";
    }
  }

  static String? passwordsValidator(String? password1, String? password2) {
    if (password1 != null && password2 != null && password1 != password2) {
      return "Passwords must match";
    } else if (password1 != null &&
        password2 != null &&
        !(password1.length >= 8 || password2.length >= 8)) {
      return "Password must be at least 8 characters.";
    } else if (password1 != null &&
        password2 != null &&
        password1.isNotEmpty &&
        password2.isNotEmpty &&
        password1 == password2) {
      return null;
    } else {
      return "Passwords must match";
    }
  }
}

class FieldValidator {
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Enter Email';
    }
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return "Enter Phone Number";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please enter password";
    }
    if (value.length < 8) {
      return "Password should contain at least 8 characters";
    }
    if (!RegExp(r"^(?=.*[A-Za-z@#$])(?=.*\d).{8,}$").hasMatch(value)) {
      return "Password should be alphanumeric";
    }
    return null;
  }

  static String? validateStartDate(String? value) {
    if (value!.isEmpty) {
      return "Please select start date";
    }
    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value!.isEmpty) {
      return "Enter Password";
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value!.isEmpty) {
      return "Please Select date";
    }
    return null;
  }

  static String? validatePasswordMatch(String? value, String? pass2) {
    if (pass2!.isEmpty) {
      return "Please re-enter your password";
    }
    if (value != pass2) {
      return "Password doesn't match";
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Your Name";
    }
    if (value.length <= 2) {
      return "Invalid Name";
    } else if (!RegExp(r'^[^\s]').hasMatch(value)) {
      return "Invalid Name";
    }
    if (!RegExp(r"^([ \u00c0-\u01ffa-zA-Z'\-])+$").hasMatch(value)) {
      return "Invalid Name";
    }
    return null;
  }

  static String? validateEmptyField(String? value) {
    if (value!.isEmpty) {
      return "Field can't be empty";
    }
    return null;
  }

  static String? location(String? value) {
    if (value!.isEmpty) {
      return "Please Enter your location";
    }

    return null;
  }
}

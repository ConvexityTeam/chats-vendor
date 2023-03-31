class Validators {
  static String? validateName(String? newVal) {
    if (newVal == null)
      return "Enter a valid name";
    else
      return newVal.isEmpty ? "cannot be empty" : null;
  }

  static String? validateEmail(String? newVal) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern.toString());
    if (newVal == null)
      return 'Enter an email address';
    else if (!regex.hasMatch(newVal))
      return 'Enter a valid email address';
    else
      return null;
  }

  static String? validatePhone(String? newVal) {
    if (newVal == null)
      return "Enter a valid phone number";
    else if (newVal.isEmpty) {
      return "Cannot be empty";
    } else if (newVal.length < 11) {
      return 'Enter a valid phone Number';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? newVal) {
    if (newVal == null)
      return "Enter a valid password";
    else if (newVal.isEmpty) {
      return "You need to enter a password";
    } else if (newVal.length < 3) {
      return 'Enter a longer password';
    } else {
      return null;
    }
  }
}

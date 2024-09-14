extension ExString on String {
  bool get isValidEmail {
    final reqexp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return reqexp.hasMatch(this);
  }

  bool get isValidName {
    final regex = RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return regex.hasMatch(this);
  }

  bool get isValidPassword {
    final regex = RegExp(r'^(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%&*]{6,20}$');
    return regex.hasMatch(this);
  }

  bool get isValidPhone {
    final regex = RegExp(r"^\+?0[0-9]{10}$");
    return regex.hasMatch(this);
  }
}

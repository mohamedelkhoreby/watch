bool passwordValid(String pass) {
  return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(pass);
}

class Validators {
  static String validateName(String value) {
    return value.isEmpty ? 'Name can\'t be empty' : null;
  }

  static String validateLastName(String value) {
    return value.isEmpty ? 'Last Name can\'t be empty' : null;
  }

  static String validateEmail(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }

  static String validatePassword(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }

  static String validatePhoneNumber(String value) {
    return value.isEmpty ? 'Phone Number can\'t be empty' : null;
  }

  static String validateAddress(String value) {
    return value.isEmpty ? 'Address can\'t be empty' : null;
  }

}
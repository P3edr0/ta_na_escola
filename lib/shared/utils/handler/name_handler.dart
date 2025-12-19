class NameHandler {
  static String firstName(String fullName) {
    final firstName = fullName.split(' ').first;
    return firstName;
  }
}

class FirebaseExceptionToMessage {
  final Map<String, String> errorMessages = {
    'weak-password': 'The password provided is too weak.',
    'email-already-in-use': 'The account already exists for that email.',
    'invalid-email': 'Email is not valid',
    'operation-not-allowed': 'Email/password accounts are not enabled',
    'user-not-found': "User not registred",
  };

  String get(String code) {
    return errorMessages[code] ?? "Undefined Error";
  }
}

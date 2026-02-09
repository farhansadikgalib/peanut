class ApiEndPoints {
  ApiEndPoints._();

  static const String login = 'auth/login';

  static String addonServiceDetails(int id) => 'checkr-requests/$id';
}

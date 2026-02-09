class ApiEndPoints {
  ApiEndPoints._();

  static const String login = 'IsAccountCredentialsCorrect';
  static const String profile = 'GetAccountInformation';

  static String addonServiceDetails(int id) => 'checkr-requests/$id';
}

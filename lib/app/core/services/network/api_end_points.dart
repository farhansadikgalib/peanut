class ApiEndPoints {
  ApiEndPoints._();

  static const String isAccountCredentialsCorrect = 'IsAccountCredentialsCorrect';
  static const String getAccountInformation = 'GetAccountInformation';

  static String addonServiceDetails(int id) => 'checkr-requests/$id';
}

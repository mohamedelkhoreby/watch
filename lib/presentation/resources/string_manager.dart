class AppStrings {
  static const String data = 'data';
  // detalis screen
  static const String releaseDataText = "releaseDataText";
  static const String overviewText = "overviewText";
  static const String votesText = "votesText";
  static const String popularityText = "popularityText";

  //login
  static const String usernameError = "usernameError";
  static const String usernameText = "usernameText";
  static const String passwoerdText = "passwoerdText";
  static const String passwordError = "passwordError";
  static const String passwordInfo = "passwordInfo";
  static const String loginBtn = "loginBtn";

  static const String success = "success";
}

class ResponseMessage {
  // API response Massage
  static const String success = "success"; // success with data
  static const String noContent = "noContent"; // success with no content
  static const String badRequest =
      "badRequest"; // failure, api rejected our request
  static const String forbidden =
      "forbidden"; // failure,  api rejected our request
  static const String unAuthorised =
      "unAuthorisedr"; // failure, user is not authorised
  static const String notFound =
      "notFound"; // failure, API url is not correct and not found in api side.
  static const String internalServerError =
      "internalServerError"; // failure, a crash happened in API side.

  // local responses Massage
  static const String unknown = "unknown"; // unknown error happened
  static const String connectTimeOut =
      "connectTimeOut"; // issue in connectivity
  static const String cancel = "cancel"; // API request was cancelled
  static const String receiveTimeOut =
      "receiveTimeOut"; //  issue in connectivity
  static const String sendTimeOut = "sendTimeOut"; //  issue in connectivity
  static const String cacheError =
      "cacheError"; //  issue in getting data from local data source (cache)
  static const String noInternetConnection =
      "noInternetConnection"; // issue in connectivity
  static const String badCertificate = "badCertificate";
  static const String connectionError = "connectionError";
}

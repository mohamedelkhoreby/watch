class AppStrings {
   static const String data = 'No Route Found';
  // detalis screen
  static const String releaseDataText = "Release Date:";
  static const String overviewText = "Overview";
  static const String votesText = "votes";
  static const String popularityText = "Popularity:";

  //login
  static const String usernameError = "Enter username";
  static const String usernameText = "Username";
  static const String passwoerdText = "Password";
  static const String passwordError = "Password cannot be empty";
  static const String passwordInfo =
      "Password must contain at least\none uppercase letter One lowercase letter and one number";
  static const String loginBtn = "Login";

  static const String success = "Success";
}

class ResponseMessage {
  // API response Massage
  static const String success = "success"; // success with data
  static const String noContent = "No Content"; // success with no content
  static const String badRequest =
      "Bad Request "; // failure, api rejected our request
  static const String forbidden =
      "Forbidden"; // failure,  api rejected our request
  static const String unAuthorised =
      "Unauthorized Error"; // failure, user is not authorised
  static const String notFound =
      "Not Foundd Error"; // failure, API url is not correct and not found in api side.
  static const String internalServerError =
      "Internal Server Error"; // failure, a crash happened in API side.

  // local responses Massage
  static const String unknown = "unknown Error"; // unknown error happened
  static const String connectTimeOut =
      "Connection Timeout"; // issue in connectivity
  static const String cancel = "Request Cancelled"; // API request was cancelled
  static const String receiveTimeOut =
      "Receive Timeout"; //  issue in connectivity
  static const String sendTimeOut = "Send Timeout"; //  issue in connectivity
  static const String cacheError =
      "Cash Error"; //  issue in getting data from local data source (cache)
  static const String noInternetConnection =
      "No Internet Connection "; // issue in connectivity
  static const String badCertificate = "Bad Certificate Error";
  static const String connectionError = "Connection Error";
}

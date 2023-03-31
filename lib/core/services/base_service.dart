class BaseService {
  // static String _$rootApi = "https://api.chats.cash/v1/";
  static const String rootApi = const String.fromEnvironment('BASE_URL');

  Map<String, String> header = {"Content-Type": "application/json"};
}

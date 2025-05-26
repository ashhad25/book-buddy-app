abstract class BaseApiServices {
  Future<dynamic> getUserAPi(String url);
  Future<dynamic> postUserApi(dynamic data, String url);
  Future<dynamic> getBooksApi(String url);
  Future<dynamic> getBooksGenreApi(String url, String genre);
  Future<dynamic> getBooksQueryApi(String url, String query);
}

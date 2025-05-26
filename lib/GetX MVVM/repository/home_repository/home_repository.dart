import 'package:book_buddy/GetX%20MVVM/data/network/network_api_services.dart';
import 'package:book_buddy/GetX%20MVVM/models/home/book_list_model.dart';
import 'package:book_buddy/GetX%20MVVM/models/home/user_list_model.dart';
import 'package:book_buddy/GetX%20MVVM/resources/app%20urls/app_urls.dart';

class HomeRepository {
  final _apiService = NetworkApiServices();

  Future<UserListModel> usersListApi() async {
    dynamic response = await _apiService.getUserAPi(AppUrls.userListApi);
    return UserListModel.fromJson(response);
  }

  Future<BookListModel> bookListApi() async {
    dynamic response = await _apiService.getBooksApi(AppUrls.bookListApi);
    return BookListModel.fromJson(response);
  }

  Future<BookListModel> bookListGenreApi(String genre) async {
    dynamic response = await _apiService.getBooksGenreApi(
      AppUrls.bookListApi,
      genre,
    );
    return BookListModel.fromJson(response);
  }

  Future<BookListModel> bookListQueryApi(String query) async {
    dynamic response = await _apiService.getBooksQueryApi(
      AppUrls.bookListApi,
      query,
    );
    return BookListModel.fromJson(response);
  }
}

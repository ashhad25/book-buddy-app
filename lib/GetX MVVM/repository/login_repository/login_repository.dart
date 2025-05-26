import 'package:book_buddy/GetX%20MVVM/data/network/network_api_services.dart';
import 'package:book_buddy/GetX%20MVVM/resources/app%20urls/app_urls.dart';

class LoginRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> loginApi(var data) async {
    dynamic response = await _apiService.postUserApi(data, AppUrls.loginApi);
    return response;
  }
}

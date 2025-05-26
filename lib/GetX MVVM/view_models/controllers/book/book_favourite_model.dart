import 'package:get/get.dart';

class BookFavouriteModel extends GetxController {
  var favourites = <Map<String, dynamic>>[].obs;

  var favCounter = 0.obs;

  bool isFavourite(int id) {
    return favourites.any((book) => book['id'] == id);
  }

  void toggleFavourite(Map<String, dynamic> book) {
    final index = favourites.indexWhere((b) => b['id'] == book['id']);
    if (index == -1) {
      favourites.add(book); // Add to favourites
      favCounter.value++;
    } else {
      favourites.removeAt(index); // Remove from favourites
      favCounter.value--;
    }
    print(favCounter.value);
  }
}

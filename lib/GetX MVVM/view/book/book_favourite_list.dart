import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:book_buddy/GetX%20MVVM/view/base_view.dart';
import 'package:book_buddy/GetX%20MVVM/view/book/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/book/book_favourite_model.dart';

class BookFavouriteList extends StatelessWidget {
  const BookFavouriteList({super.key});

  @override
  Widget build(BuildContext context) {
    final favouriteModel = Get.put(BookFavouriteModel());

    return BaseView(
      child: Scaffold(
        body: Obx(() {
          final favourites = favouriteModel.favourites;
          if (favourites.isEmpty) {
            return const Center(
              child: Text(
                "No favourite books yet.",
                style: TextStyle(color: AppColors.whiteColor, fontSize: 20),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.65,
            ),
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              final books = favourites[index];
              return Card(
                elevation: 4,
                color: AppColors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 15,
                    bottom: 10,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: const Duration(
                              milliseconds: 500,
                            ),
                            reverseTransitionDuration: const Duration(
                              milliseconds: 400,
                            ),
                            pageBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                ) => BookDetailScreen(
                                  id: books['id'],
                                  imageUrl: books['imageUrl'],
                                  title: books['title'] ?? 'Unknown Title',
                                  author:
                                      books['author'].isNotEmpty
                                          ? books['author'] ?? 'Unknown Author'
                                          : 'Unknown Author',
                                  description: books['description'].toString(),
                                ),
                            transitionsBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                            ) {
                              final curved = CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOutBack,
                              );
                              return ScaleTransition(
                                scale: curved,
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                          ),
                        );
                      },

                      child: Image.network(
                        books['imageUrl'],
                        fit: BoxFit.fill,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

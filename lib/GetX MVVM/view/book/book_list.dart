import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:book_buddy/GetX%20MVVM/view/book/book_detail.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookList extends StatelessWidget {
  BookList({super.key});

  final homeViewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    final books = homeViewModel.bookList.value.results!;
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
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
                      transitionDuration: const Duration(milliseconds: 500),
                      reverseTransitionDuration: const Duration(
                        milliseconds: 400,
                      ),
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              BookDetailScreen(
                                id: books[index].id,
                                imageUrl:
                                    books[index].formats!.imageJpeg.toString(),
                                title: books[index].title ?? 'Unknown Title',
                                author:
                                    books[index].authors.isNotEmpty
                                        ? books[index].authors[0].name ??
                                            'Unknown Author'
                                        : 'Unknown Author',
                                description: books[index].summaries.toString(),
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
                  books[index].formats!.imageJpeg.toString(),
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
  }
}

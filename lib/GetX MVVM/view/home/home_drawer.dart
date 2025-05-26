import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final homeViewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      backgroundColor: AppColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.my_library_books_rounded,
                      color: AppColors.primaryColor,
                    ),
                    backgroundColor: AppColors.selectedIconColor,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Book Genres',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                      [
                        'All',
                        ...List.generate(
                          26,
                          (index) => String.fromCharCode(65 + index),
                        ),
                      ].map((letter) {
                        final isSelected =
                            homeViewModel.selectedLetter.value == letter;
                        return GestureDetector(
                          onTap: () => homeViewModel.setSelectedLetter(letter),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? Colors.white
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white),
                            ),
                            child: Text(
                              letter,
                              style: TextStyle(
                                color:
                                    isSelected
                                        ? AppColors.primaryColor
                                        : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: homeViewModel.filteredGenres.length,
                itemBuilder: (context, index) {
                  final genreKey = homeViewModel.filteredGenres[index];
                  final displayGenre = genreKey.replaceAll('_', ' ');

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0 ||
                          homeViewModel.filteredGenres[index - 1][0]
                                  .toUpperCase() !=
                              genreKey[0].toUpperCase())
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            genreKey[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      Obx(() {
                        final isSelected =
                            homeViewModel.selectedGenre.value == genreKey;
                        return ListTile(
                          leading: Icon(
                            isSelected
                                ? Icons.bookmark
                                : Icons.bookmark_outline,
                            color: Colors.white,
                          ),
                          title: Text(
                            displayGenre[0].toUpperCase() +
                                displayGenre.substring(1),
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            homeViewModel.setSelectedGenre(genreKey);
                            homeViewModel.bookListApi('', genreKey);
                          },
                        );
                      }),
                      const Divider(color: Colors.white24),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

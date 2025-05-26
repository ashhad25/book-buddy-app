import 'dart:ui';

import 'package:book_buddy/GetX%20MVVM/data/response/status.dart';
import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:book_buddy/GetX%20MVVM/resources/components/bottom_bar.dart';
import 'package:book_buddy/GetX%20MVVM/resources/components/general_exception.dart';
import 'package:book_buddy/GetX%20MVVM/resources/components/gradient_background_widget.dart';
import 'package:book_buddy/GetX%20MVVM/view/book/book_favourite_list.dart';
import 'package:book_buddy/GetX%20MVVM/view/book/book_list.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeBody extends StatefulWidget {
  HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> with TickerProviderStateMixin {
  final homeViewModel = Get.put(HomeViewModel());

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    // Schedule the API call after the widget build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeViewModel.bookListApi('', '');
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Animate on currentIndex changes
    ever<int>(homeViewModel.currentIndex, (index) {
      if (index == 1) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    homeViewModel.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Stack(
        children: [
          Obx(() {
            switch (homeViewModel.rxRequestStatus.value) {
              case Status.LOADING:
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.65, // adjust based on image size
                        ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          height: 20,
                          width: 200,
                          color: AppColors.transparent,
                        ),
                      );
                    },
                  ),
                );
              case Status.ERROR:
                return GeneralExceptionWidget(
                  errorText: homeViewModel.error.value,
                  onPress: () {
                    homeViewModel.refreshApi();
                  },
                );
              case Status.COMPLETETD:
                return Stack(
                  children: [
                    homeViewModel.currentIndex == 1 ||
                            homeViewModel.currentIndex == 0
                        ? BookList()
                        : BookFavouriteList(),

                    // Only blur background when on index 1
                    if (homeViewModel.currentIndex == 1)
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                      ),

                    // Search bar should always be present for animation
                    SlideTransition(
                      position: _offsetAnimation,
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 50,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackColor,
                              blurRadius: 30,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search books...',
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: AppColors.whiteColor,
                                  size: 30,
                                ),
                                hintStyle: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              onSubmitted: (value) {
                                String query = value.trim();
                                homeViewModel.bookListApi(query, '');
                                homeViewModel.setCurrentIndex(0);
                                homeViewModel.setSelectedGenre('');
                              },
                              style: TextStyle(color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
            }
          }),
          Align(alignment: Alignment.bottomCenter, child: BottomBar()),
        ],
      ),
    );
  }
}

import 'package:book_buddy/GetX%20MVVM/view_models/controllers/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});

  final List<IconData> _iconsUnselected = [
    Icons.home_outlined,
    Icons.search,
    Icons.favorite_outline,
  ];
  final List<IconData> _iconsSelected = [
    Icons.home,
    Icons.search,
    Icons.favorite,
  ];
  final List<String> _titles = ['Home', 'Search', 'Favorite'];
  final homeViewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(right: 15, left: 18, bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor,
            blurRadius: 30,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_iconsUnselected.length, (index) {
            bool isSelected = homeViewModel.currentIndex == index;
            return GestureDetector(
              onTap: () {
                homeViewModel.setCurrentIndex(index);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isSelected
                        ? _iconsSelected[index]
                        : _iconsUnselected[index],
                    color:
                        isSelected
                            ? AppColors.selectedIconColor
                            : AppColors.unSelectedIconColor,
                    size: 25,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _titles[index],
                    style: TextStyle(
                      fontSize: 15,
                      color:
                          isSelected
                              ? AppColors.selectedIconColor
                              : AppColors.unSelectedIconColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

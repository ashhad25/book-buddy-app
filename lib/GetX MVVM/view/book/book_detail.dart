import 'dart:ui';
import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:book_buddy/GetX%20MVVM/resources/components/gradient_background_widget.dart';
import 'package:book_buddy/GetX%20MVVM/view/base_view.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/book/book_favourite_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:get/get.dart';

class BookDetailScreen extends StatelessWidget {
  final String? imageUrl, title, description, author;
  final int? id;

  const BookDetailScreen({
    super.key,
    this.imageUrl,
    this.title,
    this.description,
    this.author,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    // Inside your build method or widget where description is used:
    final Random random = Random();

    String getRandomDescription(String desc) {
      if (desc.length > 200) {
        // Random length between 400 and desc.length (or max 600 chars if you want to limit)
        int maxLength = desc.length < 500 ? desc.length : 500;
        int randomLength = 250 + random.nextInt(maxLength - 400 + 1);
        return '${desc.substring(2, randomLength)}...';
      } else {
        return desc;
      }
    }

    final bookFavouriteModel = Get.put(BookFavouriteModel());

    return BaseView(
      child: Scaffold(
        body: GradientBackground(
          child: Stack(
            children: [
              // Full screen background image with blur
              Positioned.fill(
                child:
                    imageUrl != null && imageUrl!.isNotEmpty
                        ? Stack(
                          children: [
                            Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                            Positioned.fill(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 25,
                                  sigmaY: 25,
                                ),
                                child: Container(
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ),
                            ),
                          ],
                        )
                        : Container(color: Colors.black54),
              ),
              // Top app bar with back and favorite buttons
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.whiteColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Obx(
                      () => IconButton(
                        onPressed: () {
                          bookFavouriteModel.toggleFavourite({
                            'id': id,
                            'title': title,
                            'author': author,
                            'description': description,
                            'imageUrl': imageUrl,
                          });
                        },
                        icon:
                            bookFavouriteModel.isFavourite(id ?? -1)
                                ? Icon(Icons.favorite)
                                : Icon(Icons.favorite_outline),
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Main content centered
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Book cover image with shadow
                  Positioned(
                    top: 120,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 25,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child:
                            imageUrl != null && imageUrl!.isNotEmpty
                                ? Image.network(
                                  imageUrl!,
                                  height: 350,
                                  width: 250,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 350,
                                      width: 250,
                                      color: AppColors.transparent,
                                      child: const Center(
                                        child: Icon(
                                          Icons.book,
                                          size: 60,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    );
                                  },
                                )
                                : Container(
                                  height: 350,
                                  width: 250,
                                  color: AppColors.transparent,
                                  child: const Center(
                                    child: Icon(
                                      Icons.book,
                                      size: 60,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                      ),
                    ),
                  ),

                  // Book details at bottom
                  Positioned(
                    bottom: 80,
                    left: 24,
                    right: 24,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title ?? "No title available.",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          author ?? "Unknown Author",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          description != null || description == '[]'
                              ? getRandomDescription(description!)
                              : "No description available.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

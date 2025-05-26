import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    this.loading = false,
    required this.onPressed,
    required this.text,
    this.color = AppColors.primaryButtonColor,
    this.textColor = AppColors.whiteColor,
    this.loadingColor = AppColors.whiteColor,
    // required this.radius,
    this.width = 60,
    this.height = 50,
    // required this.iconSize,
    // required this.icon,
  });

  final bool loading;
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final Color textColor;
  final Color loadingColor;
  // final double radius;
  final double width;
  final double height;
  // final double iconSize;
  // final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.transparent, // Removes the ripple effect
        highlightColor: Colors.transparent, // Removes highlight on tap down
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: textColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child:
              loading
                  ? Center(
                    child: CircularProgressIndicator(color: loadingColor),
                  )
                  : Center(
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: textColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
        ),
      ),
    );
  }
}

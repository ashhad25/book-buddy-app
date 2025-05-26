import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:flutter/material.dart';

class GeneralExceptionWidget extends StatefulWidget {
  final String errorText;
  final VoidCallback onPress;
  const GeneralExceptionWidget({
    super.key,
    required this.onPress,
    required this.errorText,
  });

  @override
  State<GeneralExceptionWidget> createState() => _GeneralExceptionWidgetState();
}

class _GeneralExceptionWidgetState extends State<GeneralExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off, color: AppColors.primaryColor, size: 50),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                widget.errorText,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
          ),
          SizedBox(height: height * .05),
          InkWell(
            onTap: widget.onPress,
            child: Container(
              height: 44,
              width: 160,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  'Retry',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: AppColors.whiteColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

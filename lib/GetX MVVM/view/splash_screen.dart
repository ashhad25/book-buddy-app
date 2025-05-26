import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:book_buddy/GetX%20MVVM/view/base_view.dart';
import 'package:flutter/material.dart';
import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/services/splash_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  SplashServices splashServices = SplashServices();

  final ScrollController _scrollController = ScrollController();
  late Timer _autoScrollTimer;

  final List<String> bookAssets = [
    'assets/images/book1.jpg',
    'assets/images/book2.jpg',
    'assets/images/book3.jpg',
    'assets/images/book4.jpg',
    'assets/images/book5.jpg',
    'assets/images/book6.jpeg',
    'assets/images/book7.jpg',
  ];

  double _scrollOffset = 0.0;
  final double _itemExtent = 300.0;

  late AnimationController _introAnimationController;
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();

    // animations and timers
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });

    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      setState(() {
        _scrollOffset += 0.03;
      });
    });

    _introAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..forward();

    _shimmerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: false);

    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _autoScrollTimer.cancel();
    _introAnimationController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  Widget buildCarousel() {
    return AnimatedBuilder(
      animation: _introAnimationController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: List.generate(bookAssets.length, (index) {
            double angle =
                (_scrollOffset) + (index * (2 * pi / bookAssets.length));
            double radius = 400;

            // X and Z position in circular motion
            double x = radius * cos(angle);
            double z = radius * sin(angle);

            // 3D effect based on depth (z-axis)
            double scale = (0.6 + 0.4 * (z + radius) / (2 * radius)).clamp(
              0.6,
              1.0,
            );
            double opacity = (0.2 + 0.8 * (z + radius) / (2 * radius)).clamp(
              0.0,
              1.0,
            );

            return Positioned(
              left:
                  MediaQuery.of(context).size.width / 2 +
                  x -
                  (_itemExtent * scale) / 2,
              child: FadeTransition(
                opacity: AlwaysStoppedAnimation(opacity),
                child: Container(
                  width: _itemExtent * scale,
                  height: 500 * scale,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.0),
                            Colors.white.withOpacity(0.4),
                            Colors.white.withOpacity(0.0),
                          ],
                          stops: const [0.1, 0.5, 0.9],
                          begin: Alignment(-1.0, -0.3),
                          end: Alignment(1.0, 0.3),
                          transform: GradientRotation(pi / 4),
                        ).createShader(
                          Rect.fromLTWH(
                            bounds.width * _shimmerAnimation.value,
                            0,
                            bounds.width,
                            bounds.height,
                          ),
                        );
                      },
                      blendMode: BlendMode.srcATop,
                      child: Image.asset(bookAssets[index], fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A2980), Color(0xFF26D0CE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.book, color: AppColors.whiteColor, size: 40),
                      SizedBox(width: 5),
                      Text(
                        'Book Buddy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          shadows: [
                            Shadow(
                              blurRadius: 8,
                              color: Colors.black45,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Read. Learn. Grow.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 30),

                  /// Increase carousel height
                  SizedBox(height: 500, child: buildCarousel()),

                  const SizedBox(height: 40),
                  SpinKitDancingSquare(color: AppColors.whiteColor, size: 50),

                  /// Replace Spacer with fixed height to avoid layout jumping
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

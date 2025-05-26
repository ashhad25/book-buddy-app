import 'package:book_buddy/GetX%20MVVM/resources/components/scale_fade_transition.dart';
import 'package:book_buddy/GetX%20MVVM/resources/routes/route_names.dart';
import 'package:book_buddy/GetX%20MVVM/view/auth/login_view.dart';
import 'package:book_buddy/GetX%20MVVM/view/auth/register_view.dart';
import 'package:book_buddy/GetX%20MVVM/view/book/book_detail.dart';
import 'package:book_buddy/GetX%20MVVM/view/home/home_view.dart';
import 'package:book_buddy/GetX%20MVVM/view/splash_screen.dart';
import 'package:book_buddy/GetX%20MVVM/view/user/user_profile.dart';
import 'package:get/get.dart';

class Routes {
  static appRoutes() => [
    GetPage(name: RouteNames.splash, page: () => SplashScreen()),
    GetPage(
      name: RouteNames.loginView,
      page: () => LoginView(),
      customTransition: ScaleFadeTransition(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteNames.homeView,
      page: () => HomeView(),
      customTransition: ScaleFadeTransition(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteNames.registerView,
      page: () => RegisterView(),
      customTransition: ScaleFadeTransition(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteNames.bookDetail,
      page: () => BookDetailScreen(),
      customTransition: ScaleFadeTransition(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteNames.userProfile,
      page: () => UserProfile(),
      customTransition: ScaleFadeTransition(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}

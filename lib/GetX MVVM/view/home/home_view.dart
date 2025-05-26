import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:book_buddy/GetX%20MVVM/resources/routes/route_names.dart';
import 'package:book_buddy/GetX%20MVVM/utils/utils.dart';
import 'package:book_buddy/GetX%20MVVM/view/base_view.dart';
import 'package:book_buddy/GetX%20MVVM/view/home/home_body.dart';
import 'package:book_buddy/GetX%20MVVM/view/home/home_drawer.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/auth/login_view_model.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/home/home_view_model.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/user%20preferences/user_preferences_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserPreferencesViewModel _userPreferencesViewModel =
      UserPreferencesViewModel();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userPreferencesViewModel.dispose();
  }

  final homeViewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Utils.showDialog(
            "Exit App",
            "Are you sure you want to exit the app?",
            context,
            () => SystemNavigator.pop(), // or exit(0)
          );
        }
      },
      child: BaseView(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: Builder(
              builder:
                  (context) => IconButton(
                    icon: const Icon(Icons.menu_book_sharp),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
            ),
            title: InkWell(
              splashColor: AppColors.transparent,
              highlightColor: AppColors.transparent,
              onTap: () {
                homeViewModel.refreshApi();
              },
              child: Text('home_appbar'.tr),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(RouteNames.userProfile);
                },
                icon: Icon(Icons.person_outline, size: 30),
              ),
              IconButton(
                onPressed: () {
                  Utils.showDialog(
                    'Log Out',
                    'Are you sure you want to log out?',
                    context,
                    () {
                      _userPreferencesViewModel.logOutUser().then((value) {
                        Get.delete<LoginViewModel>();
                        Get.toNamed(RouteNames.loginView);
                        Utils.snackBar('Success', 'Logged Out Successfully');
                      });
                    },
                  );
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          resizeToAvoidBottomInset: false,
          drawer: HomeDrawer(),
          body: HomeBody(),
        ),
      ),
    );
  }
}

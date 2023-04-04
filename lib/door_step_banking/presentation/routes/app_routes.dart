import 'package:get/get.dart';

import '../pages/splas_screen.dart';
import 'app_pages.dart';

class AppRoutes {
  static final routes = [
    // GetPage(name: AppPages.home, page: () => const HomeScreen()),
    GetPage(
      name: AppPages.splash,
      page: () => const SplashScreen(),
    ),
  ];
}

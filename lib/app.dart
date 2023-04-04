import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'door_step_banking/presentation/routes/app_pages.dart';
import 'door_step_banking/presentation/routes/app_routes.dart';
import 'door_step_banking/presentation/themes/themes.dart';
import 'door_step_banking/presentation/utils/transaltions/appTransaltions.dart';

class DoorStepDelivery extends StatelessWidget {
  const DoorStepDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslations(),
      theme: AppTheme.getTheme(),
      locale: const Locale('en', 'UK'),
      fallbackLocale: const Locale('en', 'UK'),
      transitionDuration: const Duration(milliseconds: 400),
      getPages: AppRoutes.routes,
      initialRoute: AppPages.splash,
    );
  }
}

// import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/api_provider.dart';
import 'core/connection_checker.dart';
import 'core/hive_service.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //data source

  // sl.registerLazySingleton<ConnectionChecker>(
  //     () => ConnectionCheckerImpl(sl()));

  //repository

  // sl.registerLazySingleton<ConnectionRepository>(
  //     () => ConnectionCheckerImpl(sl()));

  //usecase

  //core
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());

  sl.registerLazySingleton<HiveService>(() => HiveService());

  await GetStorage.init();
  // sl.registerSingleton(NavigationBarMoksha(sl()));
  if (!kIsWeb) {
    sl.registerLazySingleton<ConnectionChecker>(
        () => ConnectionCheckerImpl(sl()));
  }

  if (!kIsWeb) {
    sl.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker());
  }

  sl.registerLazySingleton(() => GetStorage());
  //hive
}

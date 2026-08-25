import 'package:clean_architecture_and_solid_principles/movie%20app/core/services/service_locator.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/features/notifications/presentation/controller/notification.dart';
import 'package:get/get.dart';

import '../../modules/movies/presentation/controller/movie_controller.dart';
import '../../modules/tvs/presentation/controller/tv_controller.dart';


class InitialBinding implements Bindings {
  @override
  void dependencies() {
    // 🟢 Bridge GetX dependency lookup with your Service Locator factory
    Get.lazyPut<MovieController>(() => getIt<MovieController>(), fenix: true);
    Get.lazyPut<TvController>(() => getIt<TvController>(), fenix: true);
    Get.put<NotificationController>(getIt<NotificationController>(),permanent: true);

    // If you add more controllers later, register them here using:
    // Get.lazyPut<AnotherController>(() => sl<AnotherController>(), fenix: true);
  }
}
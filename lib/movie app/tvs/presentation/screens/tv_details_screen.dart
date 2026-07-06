import 'package:clean_architecture_and_solid_principles/movie%20app/tvs/presentation/components/rebuilding%20components/details%20screen%20components/app_bar.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/tvs/presentation/components/rebuilding%20components/details%20screen%20components/body.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/tvs/presentation/components/rebuilding%20components/details%20screen%20components/episodes.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/tvs/presentation/components/rebuilding%20components/details%20screen%20components/recommendations.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/tvs/presentation/controller/tv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TvDetailScreen extends StatelessWidget {
  const TvDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MovieDetailContent());
  }
}

class MovieDetailContent extends GetView<TvController> {
  const MovieDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value || controller.tvDetails.value == null) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.redAccent),
        );
      }
      return CustomScrollView(
        key: const Key('tvDetailScrollView'),
        slivers: [
          CustomAppBar(),
          CustomBody(),
          controller.selectedTab.value == 0
              ? CustomEpisodes()
              : CustomRecommendations(),
        ],
      );
    });
  }




}

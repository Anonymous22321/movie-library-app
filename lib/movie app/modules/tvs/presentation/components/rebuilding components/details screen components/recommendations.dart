import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/presentation/controller/tv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/utilizes/constance.dart';
import '../../../../domain/entities/recommendations.dart';

class CustomRecommendations extends GetView<TvController> {
  const CustomRecommendations({super.key});

  @override
  Widget build(BuildContext context) {
    return  SliverPadding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
      sliver: _showRecommendations(),
    );
  }
  Widget _showRecommendations() {
    final List<TvRecommendations> recommendations = controller.recommendations;

    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        final recommendation = recommendations[index];
        return FadeInUp(
          from: 20,
          duration: const Duration(milliseconds: 500),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            child: GestureDetector(
              onTap: () async {
                await controller.fetchTvDetails(recommendation.tvId);
              },
              child: CachedNetworkImage(
                imageUrl: imageUrl(recommendation.backdropPath),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[850]!,
                  highlightColor: Colors.grey[800]!,
                  child: Container(
                    height: 170.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 180.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }, childCount: controller.recommendations.length),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.7,
        crossAxisCount: 3,
      ),
    );
  }

}

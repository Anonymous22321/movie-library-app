import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/tvs/presentation/screens/tv_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import '../../../../core/utilizes/constance.dart';
import '../../controller/tv_controller.dart';

class TvPopularComponent extends GetView<TvController> {
  const TvPopularComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Container(
          height: 170.0,
        );
      } else if (controller.errorMessage.value != null) {
        return SizedBox(
          height: 170.0,
          child: Center(
            child: Text(
              "Something went wrong ${controller.errorOccurred()}",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        );
      } else {
        return FadeIn(
          duration: const Duration(milliseconds: 500),
          child: SizedBox(
            height: 170.0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: controller.popularTvList.length > 5
                  ? 5
                  : controller.popularTvList.length,
              itemBuilder: (context, index) {
                final movie = controller.popularTvList[index];
                return Container(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () async{
                      controller.fetchTvDetails(controller.popularTvList[index].tvId);
                      Get.to(()=> TvDetailScreen());
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      child: CachedNetworkImage(
                        width: 120.0,
                        fit: BoxFit.cover,
                        imageUrl: imageUrl(movie.backdropPath),
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
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    });
  }
}

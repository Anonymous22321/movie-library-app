import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/tvs/domain/entities/tv.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/tvs/presentation/controller/tv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utilizes/constance.dart';
import '../../screens/tv_details_screen.dart';

class FullTvList extends GetView<TvController> {
  final RxList<Tv> tvList;
  const FullTvList({super.key,required this.tvList});

  @override
  Widget build(BuildContext context) {
    if(controller.errorMessage.value!=null){
      return SliverToBoxAdapter(
        child: Center(
          child: Text(
            "Something went wrong ${controller.errorOccurred()}",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      );
    }
    else {
      return SliverList.separated(
      itemCount: tvList.length,
      itemBuilder: (context, index) {
        final tv = tvList[index];
        return InkWell(
          onTap: () {
            controller.fetchTvDetails(tv.tvId);
            Get.to(() => TvDetailScreen());
          },
          child: Container(
            height: Get.height * .18,
            decoration: BoxDecoration().copyWith(
              borderRadius: BorderRadius.circular(18),
              color: Colors.grey.shade800,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  child: CachedNetworkImage(
                    height: Get.height,
                    width: 120.0,
                    fit: BoxFit.cover,
                    imageUrl: imageUrl(tv.backdropPath),
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[850]!,
                      highlightColor: Colors.grey[800]!,
                      child: Container(
                        height: 150.0,
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
                const SizedBox(width: 12.0),

                // 🟢 FIX: Wrap this section in an Expanded widget so the Row boundaries constrain it!
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 8.0), // Added small right padding for spacing
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // Keeps column compact
                      children: [
                        Text(
                          tv.name,
                          style: GoogleFonts.redHatDisplay(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis, // Safe to use now!
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2.0,
                                horizontal: 8.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Colors.red.shade400,
                              ),
                              child: Text(
                                tv.firstAirDate.split("-")[0],
                                style: GoogleFonts.redHatDisplay(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              (tv.voteAverage / 2).toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          tv.overview,
                          style: GoogleFonts.redHatDisplay(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis, // 🟢 This will wrap perfectly to 3 lines now!
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 12.0),
    );
    }
  }
}

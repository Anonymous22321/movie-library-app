import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/tvs/presentation/controller/tv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/utilizes/constance.dart';
import '../../../../domain/entities/seasons.dart';

class CustomEpisodes extends GetView<TvController> {
  const CustomEpisodes({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
      sliver: _showSeasons(),
    );
  }

  Widget _showSeasons() {
    final List<Season> seasons = controller.seasons;

    // If seasons list is empty, return an empty sliver placeholder to avoid crashes
    if (seasons.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return Obx( ()=>SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              Container(
                width: Get.width,
                padding: .symmetric(horizontal: 12),
                decoration: BoxDecoration().copyWith(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.grey.shade800,
                ),
                child: DropdownButton<int>(
                  dropdownColor: Colors.grey.shade800,
                  // Matches your app's dark theme
                  style: GoogleFonts.redHatDisplay(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  isExpanded: true,
                  value: controller.selectedSeasonIndex.value,
                  items: List.generate(seasons.length, (index) {
                    final season = seasons[index];
                    return DropdownMenuItem<int>(
                      value: index,
                      child: Text(
                        season.name,
                        style: GoogleFonts.redHatDisplay(fontSize: 21),
                      ),
                    );
                  }),
                  onChanged: (int? value) {
                    // Handle season selection state shifts inside your controller here
                    controller.changeSeason(value!);
                  },
                ),
              ),
              const SizedBox(height: 8.0),
              ListView.separated(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount:
                seasons[controller.selectedSeasonIndex.value].episodes.length,
                itemBuilder: (context, index) {
                  final episode = seasons[controller.selectedSeasonIndex.value]
                      .episodes[index];
                  return Container(
                    width: Get.width,
                    decoration: BoxDecoration().copyWith(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.grey.shade900,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              child: CachedNetworkImage(
                                height: Get.height * .07,
                                width: 120.0,
                                fit: BoxFit.fill,
                                imageUrl: imageUrl(episode.stillPath),
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
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${episode.episodeNumber}.${episode.name}",
                                    style: GoogleFonts.redHatDisplay(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    episode.airDate,
                                    style: GoogleFonts.redHatDisplay(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          episode.overview,
                          style: GoogleFonts.redHatDisplay(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 50.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

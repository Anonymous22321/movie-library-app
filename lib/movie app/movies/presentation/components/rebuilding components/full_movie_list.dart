import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utilizes/constance.dart';
import '../../../domain/entities/movie.dart';
import '../../controller/movie_controller.dart';
import '../../screens/movie_detail_screen.dart';

class FullMovieList extends GetView<MovieController> {
  final RxList<Movie> movieList;
  const FullMovieList({super.key,required this.movieList});

  @override
  Widget build(BuildContext context) {
    if(controller.isLoading.value){
      return SliverToBoxAdapter(
        child: Center(
          child: SizedBox(
            height: 170.0,
            child: CircularProgressIndicator(color: Colors.redAccent,),
          ),
        ),
      );
    }

    if(controller.error.value != null){
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
      itemCount: movieList.length,
      itemBuilder: (context, index) {
        final movie = movieList[index];
        return InkWell(
          onTap: () {
            controller.fetchMovieDetails(movie.movieId);
            Get.to(() => MovieDetailScreen());
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
                    imageUrl: imageUrl(movie.backdropPath),
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
                          movie.title,
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
                                movie.releaseDate.split("-")[0],
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
                              (movie.voteAverage / 2).toStringAsFixed(1),
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
                          movie.overview,
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

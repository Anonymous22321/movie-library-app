import 'package:clean_architecture_and_solid_principles/movie%20app/features/notifications/presentation/screens/notification.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/movies/presentation/screens/popular_movies_full_List.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/movies/presentation/screens/top_rated_movies_full_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/rebuilding components/now_playing_component.dart';
import '../components/rebuilding components/popular_component.dart';
import '../components/rebuilding components/top_rated_component.dart';
import '../components/static components/list_title_component.dart';
import '../controller/movie_controller.dart';

class MoviesScreen extends GetView<MovieController> {
  // const MoviesScreen({Key? key}) : super(key: key);
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movie Library",
          style: GoogleFonts.redHatDisplay(color: Colors.white, fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(NotificationScreen()),
            icon: Icon(Icons.notifications),
          ),
        ],
        animateColor: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          key: const Key('movieScrollView'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Method in package animate_do for animation
              const NowPlayingComponent(),
              ListTitleComponent(
                title: "Popular",
                onTap: () => Get.to(() => const PopularMoviesFullList()),
              ),
              const PopularComponent(),
              ListTitleComponent(
                title: "Top Rated",
                onTap: () => Get.to(() => const TopRatedMoviesFullList()),
              ),
              const TopRatedComponent(),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}

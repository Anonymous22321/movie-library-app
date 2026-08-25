import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/presentation/components/rebuilding%20components/on_the_air_component.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/presentation/screens/popular_tv_full_list.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/presentation/screens/top_rated_tv_full_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/rebuilding components/top_rated_component.dart';
import '../../../movies/presentation/components/static components/list_title_component.dart';
import '../components/rebuilding components/popular_component.dart';
import '../controller/tv_controller.dart';

class TvScreen extends GetView<TvController> {
  // const MoviesScreen({Key? key}) : super(key: key);
  const TvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          key: const Key('movieScrollView'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Method in package animate_do for animation
              const OnTheAirComponent(),
              ListTitleComponent(title: "Popular", onTap: () => Get.to(()=> PopularTvFullList())),
              const TvPopularComponent(),
              ListTitleComponent(title: "Top Rated", onTap: ()=> Get.to(()=> TopRatedTvFullList())),
              const TvTopRatedComponent(),
              const SizedBox(height: 50.0),
              ],
          ),
        ),
      ),
    );
  }
}

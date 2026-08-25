import 'package:clean_architecture_and_solid_principles/movie%20app/modules/movies/presentation/controller/movie_controller.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/movies/presentation/screens/movies_screen.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/presentation/screens/tv_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlView extends GetView<MovieController> {
  const ControlView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
          ()=>  controller.currentScreen.value==0?
              MoviesScreen():TvScreen()
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        iconSize: 30,

        currentIndex: controller.currentScreen.value,
        onTap: (index) {
          controller.changeScreen(index);
        },
          items:  [
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Icon(Icons.movie),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Icon(Icons.tv),
          ),
          label: '',
        ),
      ]),
    );
  }
}

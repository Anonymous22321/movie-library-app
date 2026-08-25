import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/presentation/components/rebuilding%20components/full_tv_list.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/presentation/controller/tv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularTvFullList extends GetView<TvController> {
  const PopularTvFullList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Tvs"),
        centerTitle: true,
        titleTextStyle: GoogleFonts.redHatDisplay(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(12.0),
            sliver: FullTvList(tvList: controller.popularTvList),
          ),
        ],
      ),
    );
  }
}

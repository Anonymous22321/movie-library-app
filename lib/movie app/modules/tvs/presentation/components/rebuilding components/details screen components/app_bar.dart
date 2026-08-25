import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/utilizes/constance.dart';
import '../../../../domain/entities/tv_details.dart';
import '../../../controller/tv_controller.dart';

class CustomAppBar extends GetView<TvController> {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TvDetails tv = controller.tvDetails.value!;
    return SliverAppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back_ios),
      ),
      pinned: true,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        background: FadeIn(
          duration: const Duration(milliseconds: 500),
          child: ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                  Colors.black,
                  Colors.transparent,
                ],
                stops: [0.0, 0.5, 1.0, 1.0],
              ).createShader(Rect.fromLTRB(0.0, 0.0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: CachedNetworkImage(
              width: Get.width,
              imageUrl: imageUrl(tv.backdropPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

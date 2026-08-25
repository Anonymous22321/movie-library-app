import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/services/service_locator.dart';
import '../controller/notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt<NotificationController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.redHatDisplay(fontSize: 24),
        ),
      ),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Permission: ${controller.isPermissionGranted.value ? "Granted" : "Denied"}',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => controller.setupFCM(),
                child: const Text('Get Token'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

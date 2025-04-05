import 'package:edupilot/shared/custom_app_bar.dart';
import 'package:edupilot/shared/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Placeholder(),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
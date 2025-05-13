import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class AgendaHeaderResponsive extends StatelessWidget {
  const AgendaHeaderResponsive({
    super.key,
    required this.topBarHeight,
    required this.title,
    required this.description,
  });

  final double topBarHeight;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: topBarHeight,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LargeBodyText(title, AppColors.successColor),
          const SizedBox(height: 10),
          SmallText(description, AppColors.titleColor),
        ],
      ),
    );
  }
}
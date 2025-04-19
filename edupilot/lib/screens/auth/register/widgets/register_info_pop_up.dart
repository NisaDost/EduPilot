import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class RegisterInfoPopUp extends StatelessWidget {
  const RegisterInfoPopUp({
    super.key,
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            content
          ],
        ),
      ),
    );
  }
}
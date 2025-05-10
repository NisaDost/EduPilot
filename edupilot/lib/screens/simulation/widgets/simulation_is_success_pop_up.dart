import 'package:flutter/material.dart';
import 'package:edupilot/theme.dart';
import 'package:edupilot/shared/styled_text.dart';

class SimulationIsSuccessPopUp {
  static Future<void> show(BuildContext context, VoidCallback onSuccess) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: LargeText(
            'Simülasyonu başarılı bir şekilde uyguladın mı?', 
            AppColors.titleColor, 
            textAlign: TextAlign.center
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onSuccess();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.successColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: LargeText('Evet', AppColors.backgroundColor),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.dangerColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: LargeText('Hayır', AppColors.backgroundColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

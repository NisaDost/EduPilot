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
          title: MediumBodyText(
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
              child: LargeBodyText('Evet', AppColors.successColor),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: LargeBodyText('Hayır', AppColors.dangerColor),
            ),
          ],
        );
      },
    );
  }
}

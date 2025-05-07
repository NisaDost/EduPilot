import 'package:edupilot/helpers/icon_conversion.dart';
import 'package:edupilot/models/dtos/coupon_dto.dart';
import 'package:edupilot/shared/styled_button.dart';
import 'package:flutter/material.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';

class CouponCardPopUp extends StatelessWidget {
  final CouponDTO coupon;

  const CouponCardPopUp({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: coupon.id,
                child: Icon(
                  IconConversion().getIconFromString(coupon.icon),
                  color: AppColors.secondaryColor,
                  size: 64,
                ),
              ),
              const SizedBox(width: 8),
              LargeBodyText(coupon.name, AppColors.titleColor),
              const SizedBox(height: 8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: AppColors.textColor, fontSize: 16),
                  children: [
                    WidgetSpan(child: MediumText('Bu ürünü ${coupon.fee}', AppColors.textColor)),
                    WidgetSpan(child: Icon(Icons.bolt, color: AppColors.primaryColor, size: 20)),
                    WidgetSpan(child: MediumText(' karşılığında ', AppColors.textColor)),
                    WidgetSpan(child: MediumText('almak istediğine emin misin?', AppColors.textColor)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileScreenButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: AppColors.successColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: LargeText('Evet', AppColors.backgroundColor),
                    ),
                  ),
                  ProfileScreenButton(
                    onPressed: () => Navigator.of(context).pop(), 
                    color: AppColors.dangerColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: LargeText('Hayır', AppColors.backgroundColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

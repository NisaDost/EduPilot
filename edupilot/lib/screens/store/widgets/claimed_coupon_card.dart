import 'package:edupilot/helpers/icon_conversion.dart';
import 'package:edupilot/models/dtos/claimed_coupon_dto.dart';
import 'package:edupilot/services/coupons_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ClaimedCouponCard extends StatefulWidget {
  const ClaimedCouponCard({super.key});

  @override
  State<ClaimedCouponCard> createState() => _ClaimedCouponCardState();
}

class _ClaimedCouponCardState extends State<ClaimedCouponCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ClaimedCouponDTO>>(
      future: CouponsApiHandler().getClaimedCoupons(),
      builder: (BuildContext context, AsyncSnapshot claimedCouponSnapshot) {
        if (claimedCouponSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LoadingAnimationWidget.flickr(
              leftDotColor: AppColors.primaryColor,
              rightDotColor: AppColors.secondaryColor,
              size: 72,
              ));
        } else if (claimedCouponSnapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${claimedCouponSnapshot.error}'));
        } else if (!claimedCouponSnapshot.hasData || claimedCouponSnapshot.data!.isEmpty) {
          return const Center(child: Text('Alınmış kupon bulunamadı.'));
        }
        final List<ClaimedCouponDTO> claimedCoupons = claimedCouponSnapshot.data!;
        return Column(
          children: [
            for (ClaimedCouponDTO claimedCoupon in claimedCoupons)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/img/coupon/claimed_coupon_bg.png'),
                    fit: BoxFit.fill, // Ensure the background image fills the container
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          IconConversion().getIconFromString(claimedCoupon.couponIcon),
                          color: AppColors.secondaryColor,
                          size: 72,
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          width: 165,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LargeText(claimedCoupon.couponName, AppColors.textColor),
                              SmallText(claimedCoupon.couponDescription, AppColors.titleColor)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: Column(
                        children: [
                          FilledButton(
                            onPressed: () {
                                showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  final date = claimedCoupon.expirationDate;
                                  final formattedDate = '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                                  final formattedTime = '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
                                  return AlertDialog(
                                  content: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 24),
                                      LargeBodyText(claimedCoupon.couponName, AppColors.titleColor),
                                      const SizedBox(height: 8),
                                      MediumText('için oluşturulmuş kupon kodun', AppColors.textColor),
                                      const SizedBox(height: 16),
                                      LargeBodyText(claimedCoupon.code, AppColors.successColor),
                                      const SizedBox(height: 24),
                                      MediumBodyText('Son Kullanım Tarihi', AppColors.dangerColor),
                                      MediumBodyText(formattedDate, AppColors.textColor),
                                      MediumBodyText(formattedTime, AppColors.textColor)
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Kapat'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.successColor,
                              padding: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: SmallBodyText('Kullan', AppColors.backgroundColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

import 'package:edupilot/helpers/icon_conversion.dart';
import 'package:edupilot/models/dtos/claimed_coupon_dto.dart';
import 'package:edupilot/services/coupons_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class Code extends StatefulWidget {
  const Code({super.key});

  @override
  State<Code> createState() => _CodeState();
}

class _CodeState extends State<Code> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ClaimedCouponDTO>>(
      future: CouponsApiHandler().getClaimedCoupons(),
      builder: (BuildContext context, AsyncSnapshot claimedCouponSnapshot) {
        if (claimedCouponSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
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
                margin: EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/img/coupon/coupon_bg.png'),
                    fit: BoxFit.fill, // or BoxFit.fill, BoxFit.contain etc.
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(IconConversion().getIconFromString(claimedCoupon.couponIcon), color: AppColors.secondaryColor, size: 72),
                            const SizedBox(width: 4),
                            SizedBox(
                              width: 165,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LargeText(claimedCoupon.couponName, AppColors.textColor),
                                  XSmallText(claimedCoupon.couponDescription, AppColors.titleColor)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 8),
                          child: Column(
                            children: [
                              FilledButton(
                                onPressed: () {
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.successColor,
                                  padding: EdgeInsets.all(8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                  )
                                ),
                                child: XSmallBodyText('Satın Al', AppColors.backgroundColor)
                              ),
                              LargeText('-${claimedCoupon.code}', AppColors.dangerColor),
                              Icon(Icons.bolt, color: AppColors.primaryColor, size: 36),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
              ),
            ),
          ],
        );
      },
    );
  }
}
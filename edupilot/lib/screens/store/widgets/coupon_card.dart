import 'package:edupilot/providers/coupon_provider.dart';
import 'package:edupilot/screens/store/widgets/coupon_card_pop_up.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/models/coupon/coupon.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CouponCard extends ConsumerStatefulWidget {
  const CouponCard({super.key});

  @override
  ConsumerState<CouponCard> createState() => _CouponState();
}

class _CouponState extends ConsumerState<CouponCard> {
  @override
  Widget build(BuildContext context) {
  final coupons = ref.watch(couponsProvider);

    return Column(
      children: [
        for (Coupon coupon in coupons)
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
                        Icon(coupon.icon, color: AppColors.secondaryColor, size: 72),
                        const SizedBox(width: 4),
                        SizedBox(
                          width: 165,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StyledHeading(coupon.name, AppColors.textColor),
                              CardText(coupon.description, AppColors.titleColor)
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
                              showDialog(
                                context: context,
                                builder: (context) => CouponCardPopUp(coupon: coupon)
                              );
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.successColor,
                              padding: EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                              )
                            ),
                            child: StyledText('Satın Al', AppColors.backgroundColor)
                          ),
                          StyledHeading('-${coupon.fee}', AppColors.dangerColor),
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
  }
}

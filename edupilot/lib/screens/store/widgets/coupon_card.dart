import 'package:edupilot/helpers/icon_conversion.dart';
import 'package:edupilot/models/dtos/coupon_dto.dart';
import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/screens/store/widgets/coupon_card_pop_up.dart';
import 'package:edupilot/services/coupons_api_handler.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CouponCard extends StatefulWidget {
  const CouponCard({super.key});

  @override
  State<CouponCard> createState() => _CouponState();
}

class _CouponState extends State<CouponCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CouponDTO>>(
      future: CouponsApiHandler().getActiveCoupons(),
      builder: (BuildContext context, AsyncSnapshot couponSnapshot) {
        if (couponSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LoadingAnimationWidget.flickr(
              leftDotColor: AppColors.primaryColor,
              rightDotColor: AppColors.secondaryColor,
              size: 72,
              ));
        } else if (couponSnapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${couponSnapshot.error}'));
        } else if (!couponSnapshot.hasData || couponSnapshot.data!.isEmpty) {
          return const Center(child: Text('Kupon bulunamadı.'));
        }
        final List<CouponDTO> coupons = couponSnapshot.data!;

        return FutureBuilder<StudentDTO>(
          future: StudentsApiHandler().getLoggedInStudent(),
          builder: (BuildContext context, AsyncSnapshot studentSnapshot) {
            if (studentSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: LoadingAnimationWidget.flickr(
              leftDotColor: AppColors.primaryColor,
              rightDotColor: AppColors.secondaryColor,
              size: 72,
              ));
            } else if (studentSnapshot.hasError) {
              return Center(child: Text('Hata oluştu: ${studentSnapshot.error}'));
            } else if (!studentSnapshot.hasData) {
              return const Center(child: Text('Öğrenci bulunamadı.'));
            }
            final StudentDTO student = studentSnapshot.data!;
            return Column(
              children: [
                for (CouponDTO coupon in coupons)
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
                                Icon(IconConversion().getIconFromString(coupon.icon), color: AppColors.secondaryColor, size: 72),
                                const SizedBox(width: 4),
                                SizedBox(
                                  width: 165,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      LargeText(coupon.name, AppColors.textColor),
                                      SmallText(coupon.description, AppColors.titleColor)
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
                                        builder: (context) => CouponCardPopUp(
                                          coupon: coupon,
                                          student: student,
                                        )
                                      );
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: AppColors.successColor,
                                      padding: EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)
                                      )
                                    ),
                                    child: SmallBodyText('Satın Al', AppColors.backgroundColor)
                                  ),
                                  LargeText('-${coupon.fee}', AppColors.dangerColor),
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
      },
    );
  }
}
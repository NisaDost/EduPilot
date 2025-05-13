import 'package:edupilot/screens/store/widgets/claimed_coupon_card.dart';
import 'package:edupilot/screens/store/widgets/coupon_card.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key, required this.onRefreshStudent});

  final VoidCallback onRefreshStudent;

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int selectedTab = 0; // 0: Kuponlar, 1: Kodlarım

  @override
  Widget build(BuildContext context) {
    const double topBarHeight = 92;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: topBarHeight), // give room for buttons
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              setState(() => selectedTab = 0);
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: selectedTab == 0 ? AppColors.primaryAccent : AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            child: MediumBodyText('Tüm Kuponlar', AppColors.backgroundColor),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              setState(() => selectedTab = 1);
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: selectedTab == 1 ? AppColors.primaryAccent : AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            child: MediumBodyText('Kodlarım', AppColors.backgroundColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (selectedTab == 0)
                    Column(
                      children: [
                        CouponCard(),
                      ],
                    )
                  else
                    Column(
                      children: [
                        ClaimedCouponCard(),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            Container(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LargeBodyText('Dükkan', AppColors.successColor),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.secondaryColor,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.bolt, color: AppColors.primaryColor, size: 32),
                            FutureBuilder<int>(
                              future: StudentsApiHandler().getLoggedInStudent().then((student) => student.points),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: LoadingAnimationWidget.flickr(
                                    leftDotColor: AppColors.primaryAccent,
                                    rightDotColor: AppColors.secondaryAccent,
                                    size: 16,
                                    ));
                                } else if (snapshot.hasError) {
                                  return Text('Hata: ${snapshot.error}');
                                } else if (!snapshot.hasData) {
                                  return Text('0', style: TextStyle(color: AppColors.textColor));
                                }
                                final int points = snapshot.data!;
                                return LargeText(points.toString(), AppColors.textColor);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  SmallText('Quizlerden kazandığın puanları ödüllere dönüştürelim!',  AppColors.titleColor),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

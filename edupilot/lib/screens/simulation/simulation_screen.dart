import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class SimulationScreen extends StatefulWidget {
  const SimulationScreen({super.key});

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  @override
  Widget build(BuildContext context) {
    const double topBarHeight = 92;

    return Container(
      color: AppColors.primaryAccent,
      child: Stack(
        children: [
          // Content below top bar
          Padding(
            padding: const EdgeInsets.only(top: topBarHeight),
            child: Column(
              children: [
                // Replace with your actual simulation content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Dropdown
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: MediumBodyText('Bir çalışma tekniği ya da sınav seç...', AppColors.titleColor),
                            items: const [
                              DropdownMenuItem(value: 'technique1', child: Text('Teknik 1')),
                              DropdownMenuItem(value: 'technique2', child: Text('Teknik 2')),
                            ],
                            onChanged: (value) {
                              // Handle dropdown change
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
            
                      // Countdown label
                      Text(
                        'Süre bitmeden simülasyonu durduramazsın!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const  SizedBox(height: 36),
            
                      // Countdown Timer
                      Text(
                        '00 : 00 : 00',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 24),
            
                      // Start Button (styled like a circular timer)
                      TextButton(
                        onPressed: () {}, 
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.timer, color: AppColors.backgroundColor, size: 64),
                                const SizedBox(height: 8),
                                MediumBodyText('Başla', AppColors.backgroundColor),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
            
                      // Bottom text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          XSmallBodyText('Konsantre ol...', AppColors.backgroundColor),
                          const SizedBox(width: 4),
                        ],
                      ),
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Top bar (floating above)
          Container(
            height: topBarHeight,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LargeBodyText('Simülasyon', AppColors.successColor),
                const SizedBox(height: 10),
                XSmallBodyText('Zamana karşı yarışalım!', AppColors.titleColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 50,
      padding: EdgeInsets.zero,
      color: AppColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBarItem(Icons.card_giftcard, 0),
          _buildBarItem(Icons.book, 1),
          _buildBarItem(Icons.timer, 2),
          _buildBarItem(Icons.airplanemode_active, 3, rotate: true),
        ],
      ),
    );
  }

  Widget _buildBarItem(IconData icon, int index, {bool rotate = false}) {
    final isActive = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryAccent : Colors.transparent,
          ),
          child: Center(
            child: Transform.rotate(
              angle: rotate ? 0.785 : 0,
              child: Icon(
                icon,
                color: isActive
                    ? AppColors.secondaryColor
                    : AppColors.backgroundColor,
                size: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

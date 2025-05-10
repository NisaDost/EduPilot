import 'package:flutter/material.dart';

class Heart extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;
  final Color defaultColor;

  const Heart({
    super.key,
    required this.isFavorite,
    required this.onTap,
    required this.defaultColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: IconButton(
        icon: Icon(
          Icons.favorite,
          color: isFavorite ? const Color.fromRGBO(255, 0, 0, 1) : defaultColor,
          size: isFavorite ? 30 : 25,
        ),
        onPressed: onTap,
      ),
    );
  }
}

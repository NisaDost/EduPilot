import 'package:flutter/material.dart';

class ChangeAvatarPopUp extends StatelessWidget {
  ChangeAvatarPopUp({super.key});
  final List<String> avatarPaths = List.generate(
    9,
    (index) => 'assets/img/avatar/avatar${index + 1}.png',
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: avatarPaths.map((path) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(context, path);
              },
              child: Image.asset(
                path,
                width: 72,
                height: 72,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
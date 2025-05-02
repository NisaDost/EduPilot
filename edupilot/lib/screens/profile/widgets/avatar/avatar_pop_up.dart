import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AvatarPopUp extends StatefulWidget {
  const AvatarPopUp({super.key, required this.onSave});

  final VoidCallback onSave;

  @override
  State<AvatarPopUp> createState() => _AvatarPopUpState();
}

class _AvatarPopUpState extends State<AvatarPopUp> {
  List<String> avatarPaths = [];

  @override
  void initState() {
    super.initState();
    loadAvatars();
  }

  Future<void> loadAvatars() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    
    final paths = manifestMap.keys
        .where((String key) => key.startsWith('assets/img/avatar/'))
        .toList();

    setState(() {
      avatarPaths = paths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: avatarPaths.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Wrap(
                spacing: 12,
                runSpacing: 12,
                children: avatarPaths.map((path) {
                  return GestureDetector(
                    onTap: () {
                      final avatarFileName = path.split('/').last;
                      Navigator.pop(context, avatarFileName);
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

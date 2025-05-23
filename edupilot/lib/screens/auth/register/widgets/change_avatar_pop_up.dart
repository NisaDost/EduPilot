import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeAvatarPopUp extends StatefulWidget {
  const ChangeAvatarPopUp({super.key});

  @override
  State<ChangeAvatarPopUp> createState() => _ChangeAvatarPopUpState();
}

class _ChangeAvatarPopUpState extends State<ChangeAvatarPopUp> {
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

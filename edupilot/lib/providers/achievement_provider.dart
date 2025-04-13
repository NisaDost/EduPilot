import 'package:flutter/material.dart';
import 'package:edupilot/models/achievement/achievement.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'achievement_provider.g.dart';

// dart run build_runner watch

List<Achievement> allAchievements = [
  Achievement(id: '1', name: 'Puan Avcısı', icon: Icons.stars_outlined, description: 'avlandın'),
  Achievement(id: '2', name: 'Seribaz', icon: Icons.military_tech_outlined, description: 'fenalıksın'),
  Achievement(id: '3', name: 'Quizatör', icon: Icons.emoji_events, description: 'canavar'),
  Achievement(id: '4', name: 'Yetenek', icon: Icons.hotel_class, description: 'bla'),
];

@riverpod
class AchievementNotifier extends _$AchievementNotifier {

  // inital value
  @override
  Set<Achievement> build() {
    return const {};
  }
}

// generated providers

@riverpod
List<Achievement> achievements(ref) {
  return allAchievements;
}
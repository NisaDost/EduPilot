// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$achievementsHash() => r'abe231a9f0c34ed89084adc15bf5e28845498f12';

/// See also [achievements].
@ProviderFor(achievements)
final achievementsProvider = AutoDisposeProvider<List<Achievement>>.internal(
  achievements,
  name: r'achievementsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$achievementsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AchievementsRef = AutoDisposeProviderRef<List<Achievement>>;
String _$achievementNotifierHash() =>
    r'ace8f2ed6497661ad8ebee26ecfcc8fb397c2e82';

/// See also [AchievementNotifier].
@ProviderFor(AchievementNotifier)
final achievementNotifierProvider =
    AutoDisposeNotifierProvider<AchievementNotifier, Set<Achievement>>.internal(
      AchievementNotifier.new,
      name: r'achievementNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$achievementNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AchievementNotifier = AutoDisposeNotifier<Set<Achievement>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

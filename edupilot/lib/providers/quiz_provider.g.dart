// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizzesHash() => r'065ca6037cba198ae50d9d7f2e614660cda002c3';

/// See also [quizzes].
@ProviderFor(quizzes)
final quizzesProvider = AutoDisposeProvider<List<Quiz>>.internal(
  quizzes,
  name: r'quizzesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$quizzesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuizzesRef = AutoDisposeProviderRef<List<Quiz>>;
String _$activeQuizzesHash() => r'8ef4a18cf2d8fe7aca14c521556f935cb1cca8e4';

/// See also [activeQuizzes].
@ProviderFor(activeQuizzes)
final activeQuizzesProvider = AutoDisposeProvider<List<Quiz>>.internal(
  activeQuizzes,
  name: r'activeQuizzesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activeQuizzesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveQuizzesRef = AutoDisposeProviderRef<List<Quiz>>;
String _$quizNotifierHash() => r'000180d2d42100bd916fd8484cc5e155fae1de35';

/// See also [QuizNotifier].
@ProviderFor(QuizNotifier)
final quizNotifierProvider =
    AutoDisposeNotifierProvider<QuizNotifier, Set<Quiz>>.internal(
      QuizNotifier.new,
      name: r'quizNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$quizNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$QuizNotifier = AutoDisposeNotifier<Set<Quiz>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

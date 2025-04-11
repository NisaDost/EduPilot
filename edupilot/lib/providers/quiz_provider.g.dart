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
String _$favQuizzesHash() => r'9e52ca9d0f76d75322610f3b88b62e18b9b5f4dc';

/// See also [favQuizzes].
@ProviderFor(favQuizzes)
final favQuizzesProvider = AutoDisposeProvider<List<Quiz>>.internal(
  favQuizzes,
  name: r'favQuizzesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$favQuizzesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavQuizzesRef = AutoDisposeProviderRef<List<Quiz>>;
String _$quizNotifierHash() => r'4ae4c9135f605b21bd10eb439b93864d9f9fd1c4';

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

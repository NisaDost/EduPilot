// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lessonsHash() => r'1a830c9fa798fbb9b47e52d80b09cf36d6500c69';

/// See also [lessons].
@ProviderFor(lessons)
final lessonsProvider = AutoDisposeProvider<List<Lesson>>.internal(
  lessons,
  name: r'lessonsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$lessonsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LessonsRef = AutoDisposeProviderRef<List<Lesson>>;
String _$favLessonsHash() => r'f47d9805d2126017ce740e585a766bc015bd727d';

/// See also [favLessons].
@ProviderFor(favLessons)
final favLessonsProvider = AutoDisposeProvider<List<Lesson>>.internal(
  favLessons,
  name: r'favLessonsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$favLessonsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavLessonsRef = AutoDisposeProviderRef<List<Lesson>>;
String _$notFavLessonsHash() => r'a4fafb8f2eb2473fbaed51c6e72cb886d6842b64';

/// See also [notFavLessons].
@ProviderFor(notFavLessons)
final notFavLessonsProvider = AutoDisposeProvider<List<Lesson>>.internal(
  notFavLessons,
  name: r'notFavLessonsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notFavLessonsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotFavLessonsRef = AutoDisposeProviderRef<List<Lesson>>;
String _$lessonNotifierHash() => r'0c8eeac6688d0806944b02550632431b0cb64fc5';

/// See also [LessonNotifier].
@ProviderFor(LessonNotifier)
final lessonNotifierProvider =
    AutoDisposeNotifierProvider<LessonNotifier, Set<Lesson>>.internal(
      LessonNotifier.new,
      name: r'lessonNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$lessonNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LessonNotifier = AutoDisposeNotifier<Set<Lesson>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

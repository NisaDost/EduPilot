// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$couponsHash() => r'3778bbf34dfb81d6fe4d8f7318923fb12af88046';

/// See also [coupons].
@ProviderFor(coupons)
final couponsProvider = AutoDisposeProvider<List<Coupon>>.internal(
  coupons,
  name: r'couponsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$couponsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CouponsRef = AutoDisposeProviderRef<List<Coupon>>;
String _$couponNotifierHash() => r'9aa0f28c8c0b16a445d700ffa33a6d26f0baa86e';

/// See also [CouponNotifier].
@ProviderFor(CouponNotifier)
final couponNotifierProvider =
    AutoDisposeNotifierProvider<CouponNotifier, Set<Coupon>>.internal(
      CouponNotifier.new,
      name: r'couponNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$couponNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CouponNotifier = AutoDisposeNotifier<Set<Coupon>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

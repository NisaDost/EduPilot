import 'package:edupilot/models/coupon/coupon.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coupon_provider.g.dart';

// dart run build_runner watch

final List<Coupon> allCoupons = [
  Coupon(id: '1', icon: Icons.theaters_rounded, name: 'Sinema Bileti', description: 'Sadece anlaşmalı yerlerde geçerlidir.', fee: 1200),
  Coupon(id: '2', icon: Icons.coffee, name: 'Orta Boy Kahve', description: 'Sadece anlaşmalı yerlerde geçerlidir.', fee: 500),
  Coupon(id: '2', icon: Icons.sell, name: 'Kırtasiye Çeki (50₺)', description: 'Sadece anlaşmalı yerlerde geçerlidir.', fee: 125),
];

@riverpod
class CouponNotifier extends _$CouponNotifier {

  // inital value
  @override
  Set<Coupon> build() {
    return const {};
  }
}

// generated providers

@riverpod
List<Coupon> coupons(ref) {
  return allCoupons;
}
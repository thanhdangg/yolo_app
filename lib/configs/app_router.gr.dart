// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:yolo_app/history/history_page.dart' as _i1;
import 'package:yolo_app/home/home_page.dart' as _i2;
import 'package:yolo_app/sign_in/sign_in_page.dart' as _i3;
import 'package:yolo_app/sign_up/sign_up_page.dart' as _i4;

/// generated route for
/// [_i1.HistoryPage]
class HistoryRoute extends _i5.PageRouteInfo<HistoryRouteArgs> {
  HistoryRoute({
    _i6.Key? key,
    required List<String> imageUrls,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          HistoryRoute.name,
          args: HistoryRouteArgs(
            key: key,
            imageUrls: imageUrls,
          ),
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HistoryRouteArgs>();
      return _i1.HistoryPage(
        key: args.key,
        imageUrls: args.imageUrls,
      );
    },
  );
}

class HistoryRouteArgs {
  const HistoryRouteArgs({
    this.key,
    required this.imageUrls,
  });

  final _i6.Key? key;

  final List<String> imageUrls;

  @override
  String toString() {
    return 'HistoryRouteArgs{key: $key, imageUrls: $imageUrls}';
  }
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.SignInPage]
class SignInRoute extends _i5.PageRouteInfo<void> {
  const SignInRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.SignInPage();
    },
  );
}

/// generated route for
/// [_i4.SignUpPage]
class SignUpRoute extends _i5.PageRouteInfo<void> {
  const SignUpRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SignUpPage();
    },
  );
}

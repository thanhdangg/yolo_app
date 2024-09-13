// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:yolo_app/history/history_page.dart' as _i2;
import 'package:yolo_app/history_gallert/history_gallery_page.dart' as _i1;
import 'package:yolo_app/home/home_page.dart' as _i3;
import 'package:yolo_app/sign_in/sign_in_page.dart' as _i4;
import 'package:yolo_app/sign_up/sign_up_page.dart' as _i5;

/// generated route for
/// [_i1.HistoryGalleryPage]
class HistoryGalleryRoute extends _i6.PageRouteInfo<void> {
  const HistoryGalleryRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HistoryGalleryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryGalleryRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return _i1.HistoryGalleryPage();
    },
  );
}

/// generated route for
/// [_i2.HistoryPage]
class HistoryRoute extends _i6.PageRouteInfo<HistoryRouteArgs> {
  HistoryRoute({
    _i7.Key? key,
    List<String>? imageUrls,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          HistoryRoute.name,
          args: HistoryRouteArgs(
            key: key,
            imageUrls: imageUrls,
          ),
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<HistoryRouteArgs>(orElse: () => const HistoryRouteArgs());
      return _i2.HistoryPage(
        key: args.key,
        imageUrls: args.imageUrls,
      );
    },
  );
}

class HistoryRouteArgs {
  const HistoryRouteArgs({
    this.key,
    this.imageUrls,
  });

  final _i7.Key? key;

  final List<String>? imageUrls;

  @override
  String toString() {
    return 'HistoryRouteArgs{key: $key, imageUrls: $imageUrls}';
  }
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.SignInPage]
class SignInRoute extends _i6.PageRouteInfo<void> {
  const SignInRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.SignInPage();
    },
  );
}

/// generated route for
/// [_i5.SignUpPage]
class SignUpRoute extends _i6.PageRouteInfo<void> {
  const SignUpRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.SignUpPage();
    },
  );
}

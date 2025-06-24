// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter();

  @override
  final Map<String, PageFactory> pagesMap = {
    ExpenseAddRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ExpenseAddScreen(),
      );
    },
    ExpenseListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ExpenseListScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    HouseCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HouseCreateScreen(),
      );
    },
    HouseJoinRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HouseJoinScreen(),
      );
    },
  };
}

/// generated route for
/// [ExpenseAddScreen]
class ExpenseAddRoute extends PageRouteInfo<void> {
  const ExpenseAddRoute({List<PageRouteInfo>? children})
      : super(
          ExpenseAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpenseAddRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExpenseListScreen]
class ExpenseListRoute extends PageRouteInfo<void> {
  const ExpenseListRoute({List<PageRouteInfo>? children})
      : super(
          ExpenseListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpenseListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HouseCreateScreen]
class HouseCreateRoute extends PageRouteInfo<void> {
  const HouseCreateRoute({List<PageRouteInfo>? children})
      : super(
          HouseCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'HouseCreateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HouseJoinScreen]
class HouseJoinRoute extends PageRouteInfo<void> {
  const HouseJoinRoute({List<PageRouteInfo>? children})
      : super(
          HouseJoinRoute.name,
          initialChildren: children,
        );

  static const String name = 'HouseJoinRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    NavigationBarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NavigationBarScreen(),
      );
    },
    PlantRoute.name: (routeData) {
      final args = routeData.argsAs<PlantRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PlantScreen(plant: args.plant),
      );
    },
    ProductRoute.name: (routeData) {
      final args = routeData.argsAs<ProductRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductScreen(item: args.item),
      );
    },
    SelectCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<SelectCategoryRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SelectCategoryScreen(
          category: args.category,
          plants: args.plants,
        ),
      );
    },
    ShopRoute.name: (routeData) {
      final args = routeData.argsAs<ShopRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ShopScreen(shop: args.shop),
      );
    },
  };
}

/// generated route for
/// [NavigationBarScreen]
class NavigationBarRoute extends PageRouteInfo<void> {
  const NavigationBarRoute({List<PageRouteInfo>? children})
      : super(
          NavigationBarRoute.name,
          initialChildren: children,
        );

  static const String name = 'NavigationBarRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PlantScreen]
class PlantRoute extends PageRouteInfo<PlantRouteArgs> {
  PlantRoute({
    required Plant plant,
    List<PageRouteInfo>? children,
  }) : super(
          PlantRoute.name,
          args: PlantRouteArgs(plant: plant),
          initialChildren: children,
        );

  static const String name = 'PlantRoute';

  static const PageInfo<PlantRouteArgs> page = PageInfo<PlantRouteArgs>(name);
}

class PlantRouteArgs {
  const PlantRouteArgs({required this.plant});

  final Plant plant;

  @override
  String toString() {
    return 'PlantRouteArgs{plant: $plant}';
  }
}

/// generated route for
/// [ProductScreen]
class ProductRoute extends PageRouteInfo<ProductRouteArgs> {
  ProductRoute({
    required Item item,
    List<PageRouteInfo>? children,
  }) : super(
          ProductRoute.name,
          args: ProductRouteArgs(item: item),
          initialChildren: children,
        );

  static const String name = 'ProductRoute';

  static const PageInfo<ProductRouteArgs> page =
      PageInfo<ProductRouteArgs>(name);
}

class ProductRouteArgs {
  const ProductRouteArgs({required this.item});

  final Item item;

  @override
  String toString() {
    return 'ProductRouteArgs{item: $item}';
  }
}

/// generated route for
/// [SelectCategoryScreen]
class SelectCategoryRoute extends PageRouteInfo<SelectCategoryRouteArgs> {
  SelectCategoryRoute({
    required String category,
    required List<Plant> plants,
    List<PageRouteInfo>? children,
  }) : super(
          SelectCategoryRoute.name,
          args: SelectCategoryRouteArgs(
            category: category,
            plants: plants,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectCategoryRoute';

  static const PageInfo<SelectCategoryRouteArgs> page =
      PageInfo<SelectCategoryRouteArgs>(name);
}

class SelectCategoryRouteArgs {
  const SelectCategoryRouteArgs({
    required this.category,
    required this.plants,
  });

  final String category;

  final List<Plant> plants;

  @override
  String toString() {
    return 'SelectCategoryRouteArgs{category: $category, plants: $plants}';
  }
}

/// generated route for
/// [ShopScreen]
class ShopRoute extends PageRouteInfo<ShopRouteArgs> {
  ShopRoute({
    required Shop shop,
    List<PageRouteInfo>? children,
  }) : super(
          ShopRoute.name,
          args: ShopRouteArgs(shop: shop),
          initialChildren: children,
        );

  static const String name = 'ShopRoute';

  static const PageInfo<ShopRouteArgs> page = PageInfo<ShopRouteArgs>(name);
}

class ShopRouteArgs {
  const ShopRouteArgs({required this.shop});

  final Shop shop;

  @override
  String toString() {
    return 'ShopRouteArgs{shop: $shop}';
  }
}

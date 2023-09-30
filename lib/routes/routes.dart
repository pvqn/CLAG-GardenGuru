import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:gardenguru/screens/screen.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes =>
      [AutoRoute(page: NavigationBarRoute.page, initial: true)];
}

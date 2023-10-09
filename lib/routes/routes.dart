import 'package:auto_route/auto_route.dart';
import 'package:gardenguru/screens/screen.dart';
import 'package:gardenguru/models/plant.dart';
import 'package:gardenguru/screens/navigation_bar/shopping/shop_list.dart';
import 'package:gardenguru/models/disease.dart';
part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NavigationBarRoute.page),
        AutoRoute(page: SelectCategoryRoute.page),
        AutoRoute(page: PlantRoute.page),
        AutoRoute(page: ShopRoute.page),
        AutoRoute(page: ProductRoute.page),
        AutoRoute(page: DiseaseRoute.page),
        AutoRoute(page: DiseaseDetectRoute.page),
        AutoRoute(page: ChatWithDoctorRoute.page),
        AutoRoute(page: SignUpRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: AddPostRoute.page)
      ];
}

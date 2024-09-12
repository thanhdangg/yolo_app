import 'package:auto_route/auto_route.dart';
import 'package:yolo_app/configs/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter  {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SignInRoute.page, initial: false),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: HistoryRoute.page),
  ];
}
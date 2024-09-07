import 'package:get_it/get_it.dart';
import 'package:yolo_app/configs/app_router.dart';
final getIt = GetIt.instance;
void setupLocator(){
  getIt.registerSingleton<AppRouter>(AppRouter());
}
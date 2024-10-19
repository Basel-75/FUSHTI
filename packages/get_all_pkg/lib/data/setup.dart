import 'package:database_meth/database_meth.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton<AppModel>(AppModel());

  await initPkg();
}
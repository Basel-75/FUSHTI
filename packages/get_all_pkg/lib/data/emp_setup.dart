import 'package:database_meth/database/super_main.dart';
import 'package:database_meth/database_meth.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';

Future<void> empSetup() async {
  getIt.registerSingleton<AppModel>(AppModel());
  await initPkg();

  await SuperMain().getEmpUser();

  print(getIt.get<AppModel>().empModel);

  if (getIt.get<AppModel>().empModel != null) {
    await SuperMain().getEmpSchool();
  }
}

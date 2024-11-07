
import 'package:database_meth/database/super_main.dart';
import 'package:database_meth/database_meth.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton<AppModel>(AppModel());

  await initPkg();
  await SuperMain().getSchool();


  await SuperMain().getUserTempData();

  
// get all child for user and same time get there scholl food menu
  if (getIt.get<AppModel>().userModel != null) {
    await SuperMain().getChilds();
     await SuperMain().getChildernPlan();
     await SuperMain().getRestrictionFood();
  }
}

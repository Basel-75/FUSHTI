library database_meth;

import 'dart:developer';

import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

export 'package:database_meth/database/super.dart';

Future<void> initPkg() async {
  
  

  // await dotenv.load(fileName: ".env");
  await dotenv.load(fileName: "packages/database_meth/.env");
  

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  //await SuperMain().supabase.auth.refreshSession();
}

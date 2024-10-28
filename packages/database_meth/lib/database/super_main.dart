import 'package:database_meth/database/method/auth_mix.dart';
import 'package:database_meth/database/method/child_mix.dart';
import 'package:database_meth/database/method/emp_only/emp_mix.dart';
import 'package:database_meth/database/method/emp_only/storge_mix.dart';
import 'package:database_meth/database/method/image_mix.dart';
import 'package:database_meth/database/method/init_data_mix.dart';
import 'package:database_meth/database/method/meal_plan_mix.dart';

import 'package:database_meth/database/method/restriction_mix.dart';

import 'package:database_meth/database/method/order_mix.dart';

import 'package:database_meth/database/method/user_mix.dart';
import 'package:database_meth/database/super.dart';

class SuperMain extends Super
    with
        AuthMix,
        InitDataMix,
        ChildMix,
        MealPlanMix,
        UserMix,
        RestrictionMix,
        OrderMix,
        EmpMix,
        StorgeMix,
        ImageMix {}

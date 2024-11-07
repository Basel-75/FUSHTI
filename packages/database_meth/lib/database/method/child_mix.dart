import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';
import 'package:get_all_pkg/data/setup.dart';

mixin ChildMix {
  Future<List<ChildModel>> getAllChildernSerch(
      {required String name, required String? childClass}) async {
    final List<Map<String, dynamic>> res;

    AppModel appModel = getIt.get<AppModel>();

    List<ChildModel> lis = [];
    try {
      if (childClass == null) {
        res = await SuperMain()
            .supabase
            .from('followers')
            .select('*, school(id,name, adders, contact_number)')
            .like('name', '%$name%')
            .eq("school_id", appModel.empModel!.schoolId);

        for (var val in res) {
          final temp = ChildModel.fromJson(val);

          temp.schoolModel = SchoolModel.fromJson(val["school"]);
          lis.add(temp);
        }
      } else {
        res = await SuperMain()
            .supabase
            .from('followers')
            .select('*, school(id,name, adders, contact_number)')
            .like('name', '%$name%')
            .eq('class', childClass)
            .eq("school_id", appModel.empModel!.schoolId);

        for (var val in res) {
          final temp = ChildModel.fromJson(val);

          temp.schoolModel = SchoolModel.fromJson(val["school"]);
          lis.add(temp);
        }
      }

      return lis;
    } catch (er) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getChildById({required String childId}) async {
    try {
      final res = await SuperMain()
          .supabase
          .from("followers")
          .select()
          .eq("id", childId);

      return res[0];
    } catch (er) {
      rethrow;
    }
  }

  getChilds() async {
    AppModel appModel = getIt.get<AppModel>();
    try {
      final childLis = await SuperMain()
          .supabase
          .from("followers")
          .select()
          .eq("user_id", appModel.userModel!.id);

// can add triger here
      for (var val in childLis) {
        appModel.userModel!.childModelList.add(ChildModel.fromJson(val));
      }

      for (var val in appModel.userModel!.childModelList) {
        final schollRes = await SuperMain()
            .supabase
            .from("school")
            .select()
            .eq("id", val.schoolId);

        val.schoolModel = SchoolModel.fromJson(schollRes[0]);

        final foodRes = await SuperMain()
            .supabase
            .from("food_menu")
            .select()
            .eq("school_id", val.schoolModel.id);

        for (var food in foodRes) {
          val.schoolModel.foodMenuModelList.add(FoodMenuModel.fromJson(food));
        }
      }
    } catch (er) {}
  }

  Future<Map<String, dynamic>> addChild(
      {required String name,
      required String userId,
      required List<String> allergy,
      required String childClass,
      required String imgPath,
      required String schoolId,
      required double funds}) async {
    try {
      final res = await SuperMain().supabase.from("followers").insert({
        "name": name,
        "user_id": userId,
        "funds": funds,
        "allergy": allergy,
        "class": childClass,
        "img_path": imgPath,
        "school_id": schoolId,
      }).select();

      await SuperMain().supabase.rpc('increment_followers', params: {
        'user_id': userId,
      });

      return res[0];
    } catch (er) {
      rethrow;
    }
  }

  editChild({
    required String name,
    required String id,
    required List<String> allergy,
    required String childClass,
    required String schoolId,
  }) async {
    try {
      final res = await SuperMain()
          .supabase
          .from("followers")
          .update({
            "name": name,
            "id": id,
            "allergy": allergy,
            "class": childClass,
            "school_id": schoolId,
          })
          .eq('id', id)
          .select();

      print(res);
    } catch (er) {}
  }

  deleteChild({required String id, required String userId}) async {
    try {
      await SuperMain().supabase.from('followers').delete().eq('id', id);

      await await SuperMain().supabase.rpc('decremnt_followers', params: {
        'user_id': userId,
      });
    } catch (e) {}
  }

  updateFollowersImage(
      {required String childId, required String imageUrl}) async {
    try {
      final response = await SuperMain()
          .supabase
          .from('followers')
          .update({'img_path': imageUrl}).eq('id', childId);
    } catch (e) {}
  }
}

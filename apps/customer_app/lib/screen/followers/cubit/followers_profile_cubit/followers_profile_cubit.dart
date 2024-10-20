import 'package:bloc/bloc.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'followers_profile_state.dart';

class FollowersProfileCubit extends Cubit<FollowersProfileState> {
  FollowersProfileCubit() : super(FollowersProfileInitial());


  AppModel appModel = getIt.get<AppModel>();


  






  
}

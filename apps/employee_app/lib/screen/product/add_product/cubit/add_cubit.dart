import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:employee_app/component/drop_down_item.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';

part 'add_state.dart';

class AddCubit extends Cubit<EditState> {
  AddCubit() : super(AddInitial());
  AppModel appModel = getIt.get<AppModel>();
  TextEditingController foodNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController calController = TextEditingController();
  String category = '';
  File? selectedImage;
  List<DropDownItem> allergyList = [];
  List<DropDownItem> allergy = getIt.get<AppModel>().alergy.map(
    (e) {
      return DropDownItem(e);
    },
  ).toList();
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      emit(ImagePickedState(selectedImage!));
    } else {
      emit(ErrorState(msg: 'لم يتم اختيار صور للمنتج'));
    }
  }

  Future<void> addNewProduct(FoodMenuModel product) async {
    emit(LoadingState());
   //add in DB
    try {
      if (selectedImage == null) {
        emit(ErrorState(msg: 'No image selected'));
        return;
      }

      final imageUrl = await SuperMain().uploadImage(imageFile: selectedImage!,isProductImage: true);
      final updatedProduct = FoodMenuModel(
        id: '',
        schoolId: appModel.empModel!.schoolId,
        foodName: product.foodName,
        description: product.description,
        price: product.price,
        category: product.category,
        available: product.available,
        cal: product.cal,
        allergy: allergyList.map(
          (e) {
            return e.name;
          },
        ).toList(),
        imageUrl: imageUrl,
      );
      final newProduct= await SuperMain().addProduct(product: updatedProduct);
      //Add Locale
      appModel.empModel?.schoolModel.foodMenuModelList.add(FoodMenuModel.fromJson(newProduct));
      emit(SussesState(msg: 'تمت اضافة المنتج بنجاح'));
    } catch (e) {
      emit(ErrorState(msg: 'حدث خطأ ما يرجى المحاولة مرة اخرى'));
    }
  }
  @override
  Future<void> close() {
    foodNameController.clear();
    priceController.clear();
    descriptionController.clear();
    calController.clear();
    return super.close();
  }
}

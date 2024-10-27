import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(AddInitial());
  AppModel appModel = getIt.get<AppModel>();
  TextEditingController foodName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController cal = TextEditingController();
  String category = '';
  File? selectedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); 

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      emit(ImagePickedState(selectedImage!));
    } else {
      emit(ErrorState(msg: 'No image selected'));
    }
  }

  Future<void> addNewProduct(FoodMenuModel product) async {
    emit(LoadingState());

    try {
      if (selectedImage == null) {
        emit(ErrorState(msg: 'No image selected'));
        return;
      }

      final imageUrl = await SuperMain().uploadImage(imageFile: selectedImage!);
      final updatedProduct = FoodMenuModel(
        id: '',
        schoolId: appModel.empModel!.schoolId,
        foodName: product.foodName,
        description: product.description,
        price: product.price,
        category: product.category,
        available: product.available,
        cal: product.cal,
        allergy: product.allergy,
        imageUrl: imageUrl,
      );
      await SuperMain().addProduct(product: updatedProduct);
      emit(SussesState(msg: 'Product added successfully'));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }
}

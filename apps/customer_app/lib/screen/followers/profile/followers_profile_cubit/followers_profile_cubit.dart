import 'dart:io';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/restriction_food_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/get_all_pkg.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
part 'followers_profile_state.dart';

class FollowersProfileCubit extends Cubit<FollowersProfileState> {
  FollowersProfileCubit({this.childModel}) : super(FollowersProfileInitial());
  File? selectedImage;
  int totalMealsInPlan = 0;
  AppModel appModel = getIt.get<AppModel>();
  List<RestrictionFoodModel> restrictionsFood = [];
  List<FoodMenuModel> foodMenuModelList = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fundsCon = TextEditingController();
  TextEditingController limtFunds = TextEditingController();
  bool initialValueRaido = false;

  final ChildModel? childModel;
  countTotal({required String id}) {
    for (var i in appModel.userModel!.childModelList) {
      for (var j in i.planList) {
        totalMealsInPlan += j.totalMeals;
      }
    }
  }

  refreshPage() async {
    emit(FollowersProfileInitial());
  }

  deleteChild() async {
    try {
      //Delete in DB
      emit(LoadingState());
      await SuperMain()
          .deleteChild(id: childModel!.id, userId: childModel!.userId);
      //Delete Locale
      appModel.userModel?.childModelList.removeWhere(
        (element) => element.id == childModel!.id,
      );

      appModel.userModel?.numberFollowers -= 1;
      emit(AfterDelState(msg: 'تم حذف التابع بنجاح'));
    } catch (e) {
      emit(ErrorState(msg: 'تعذر حذف التابع اعد المحاولة لاحقا'));
    }
  }

  Future<void> saveQrCode({required String childId}) async {
    emit(LoadingState());
    try {
      final qrValidationResult = QrValidator.validate(
        data: childId,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );
      final qrCode = qrValidationResult.qrCode;
      final painter = QrPainter.withQr(
        qr: qrCode!,
        gapless: true,
      );
      final picData =
          await painter.toImageData(2048, format: ImageByteFormat.png);
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/qr_code.png');
      await file.writeAsBytes(picData!.buffer.asUint8List());
    } catch (e) {
      emit(ErrorState(msg: 'حصل خطأ ما يرجى المحاولة لاحقا'));
    }
  }

  _generatePdf({required String childName}) async {
    final doc = pw.Document();
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/qr_code.png');
    final image = pw.MemoryImage(file.readAsBytesSync());

    doc.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Image(image),
          ],
        ),
      );
    }));

    final pdfFile = File(
        '${directory.path}/${childName.replaceAll(RegExp(r' '), '_')}.pdf');
    await pdfFile.writeAsBytes(await doc.save());
    return pdfFile;
  }

  Future<void> openPdf({required String childName}) async {
    emit(SuccessState(msg: 'تم انشاء البار كود بنجاح'));
    final pdfFile = await _generatePdf(childName: childName);
    OpenFile.open(pdfFile.path);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      emit(ImagePickedState(selectedImage!));
    }
  }

  Future<void> updateChildImage({required String childId}) async {
    emit(LoadingState());
    //Update in DB
    try {
      if (selectedImage == null) {
        emit(ErrorState(msg: 'لم يتم اختيار صورة'));
        return;
      }

      final imageUrl = await SuperMain()
          .uploadImage(imageFile: selectedImage!, isProductImage: false);

      final updateImageResponse = await SuperMain()
          .updateFollowersImage(childId: childId, imageUrl: imageUrl);

      //Update Locale
      for (var element in appModel.userModel!.childModelList) {
        if (element.id == childId) {
          element.imgPath = imageUrl;
        }
      }
      emit(SuccessUpdateImageState(msg: 'تم تحديث صورة التابع بنجاح'));
    } catch (e) {
      emit(ErrorUpdateImageState(msg: 'حدث خطأ ما يرجى المحاولة مرة اخرى'));
    }
  }

  addFundsChild() async {
    try {
      emit(LoadingState());

      if (formKey.currentState!.validate()) {
        if (appModel.userModel!.funds >= double.parse(fundsCon.text)) {
          await SuperMain().addfundsChild(
              childModel: childModel!, funds: double.parse(fundsCon.text));
        } else {
          emit(ErrorState(msg: " لا يوجد رصيد"));
          return;
        }

        childModel!.funds += double.parse(fundsCon.text);

        emit(SuccessState(msg: "تمت اضافة رصيد"));

        return;
      }
      emit(ErrorState(msg: "ادخل رقم"));
    } catch (er) {
      emit(ErrorState(msg: "حصل خطأ"));
      rethrow;
    }
  }

  updateOpenDay() async {
    try {
      emit(LoadingState());

      if (formKey.currentState!.validate()) {
        await SuperMain().updateChildOpenDay(
            limtFunds: double.parse(limtFunds.text),
            childModel: childModel!,
            isOpen: initialValueRaido);

        childModel!.dailyLimits = double.parse(limtFunds.text);

        childModel!.isOpenDay = initialValueRaido;

        emit(SuccessState(msg: "تمت تعديل  اليوم المفتوح"));

        return;
      }
      emit(ErrorState(msg: "ادخل رقم"));
    } catch (er) {
      emit(ErrorState(msg: "حصل خطأ"));
    }
  }

  getRestrictionFoodList({required String childId}) {
    for (var element in restrictionsFood) {}
    try {
      for (var element in appModel.userModel!.childModelList) {
        if (element.id == childId) {
          restrictionsFood = element.restrictionFood;
          for (var food in restrictionsFood) {
            foodMenuModelList
                .addAll(element.schoolModel.foodMenuModelList.where(
              (element) => element.id == food.menuItemId,
            ));
          }
        }
      }
    } catch (e) {}
  }
}

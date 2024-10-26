import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:pdf/widgets.dart' as pw;
import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/get_all_pkg.dart';
import 'package:meta/meta.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
part 'followers_profile_state.dart';

class FollowersProfileCubit extends Cubit<FollowersProfileState> {
  FollowersProfileCubit() : super(FollowersProfileInitial());
  int totalMealsInPlan = 0;
  countTotal({required String id}) {
    for (var i in appModel.userModel!.childModelList) {
      log('${i.planList}');
      for (var j in i.planList) {
        log('${j.toJson()}');
        totalMealsInPlan += j.totalMeals;
      }
    }
  }

  deleteChild({required String childId}) async {
    try {
      //Delete in DB
      emit(LoadingState());
      await SuperMain().deleteChild(id: childId);
      //Delete Locale
      appModel.userModel?.childModelList.removeWhere(
        (element) => element.id == childId,
      );
      emit(SuccessState(msg: 'تم حذف التابع بنجاح'));
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

  AppModel appModel = getIt.get<AppModel>();
}

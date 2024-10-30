library get_all_pkg;

import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';
import 'package:get_all_pkg/widget/loading_widget.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
export 'package:figma_squircle/figma_squircle.dart';
export 'package:sizer/sizer.dart';
export 'package:flutter_dotenv/flutter_dotenv.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:carousel_slider/carousel_slider.dart';
export 'package:get_storage/get_storage.dart';
export 'package:get_it/get_it.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:icons_plus/icons_plus.dart';
export 'package:supabase_flutter/supabase_flutter.dart';
export 'package:pinput/pinput.dart';
export 'package:barcode_scan2/barcode_scan2.dart';
export 'package:animated_custom_dropdown/custom_dropdown.dart';
export 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
export 'package:dotted_line/dotted_line.dart';
export 'package:easy_date_timeline/easy_date_timeline.dart';
export 'package:qr_flutter/qr_flutter.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:loading_animation_widget/loading_animation_widget.dart';
export 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
export 'package:add_to_cart_animation/add_to_cart_animation.dart';
export 'package:quickalert/quickalert.dart';
export 'package:glass_kit/glass_kit.dart';
export 'package:image_picker/image_picker.dart';
export 'package:syncfusion_flutter_datepicker/datepicker.dart';

export 'package:table_calendar/table_calendar.dart';

// export 'package:intl/intl.dart';
export 'package:intl/intl.dart' hide TextDirection;

export 'package:pdf/pdf.dart';

export 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
export 'package:onesignal_flutter/onesignal_flutter.dart';

showLoadingDialog({required BuildContext context}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => const Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: LoadingWidget(),
    ),
  );
}

showConfirmDialog(
    {required BuildContext context,
    Function()? onCancelBtnTap,
    Function()? onConfirmBtnTap}) {
  QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      text: 'هل انت متأكد',
      confirmBtnText: 'نعم',
      cancelBtnText: 'لا',
      confirmBtnColor: Colors.green,
      onCancelBtnTap: onCancelBtnTap,
      onConfirmBtnTap: onConfirmBtnTap);
}

showSnackBar(
    {required BuildContext context,
    required String msg,
    required bool isError}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: isError ? Colors.red : Colors.green,
  ));
}

methhh() {}

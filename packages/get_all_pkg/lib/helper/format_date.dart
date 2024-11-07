


  import 'package:get_all_pkg/get_all_pkg.dart';

String? formatDate(DateTime? date) {
    if (date == null) {
      return null; 
    }

    
    return DateFormat('yyyy-MM-dd').format(date);
  }



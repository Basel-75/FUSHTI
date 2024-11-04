import 'package:get_all_pkg/get_all_pkg.dart';

class DropDownItem with CustomDropdownListFilter {
  final String name;

  const DropDownItem(this.name);

  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}

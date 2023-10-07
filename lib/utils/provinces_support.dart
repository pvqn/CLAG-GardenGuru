import 'package:gardenguru/models/province.dart';

List<String> getListofProvinceName(List<Province> provinces) {
  List<String> names = [];
  for (int i = 0; i < provinces.length; ++i) {
    names.add(provinces[i].name);
  }
  return names;
}

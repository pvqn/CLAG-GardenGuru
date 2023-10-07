import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gardenguru/models/province.dart';

class ProvinceProvider extends ChangeNotifier {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  List<Province> _provinces = [];

  List<Province> get provinces => _provinces;

  Future<List<Province>> fetchProvinces() async {
    try {
      DatabaseEvent event = await _database.child('provinces').once();

      Map<dynamic, dynamic>? dataMap =
          event.snapshot.value as Map<dynamic, dynamic>?;

      if (dataMap != null) {
        dataMap.forEach((provinceName, temperatureData) {
          if (temperatureData is Map<dynamic, dynamic>) {
            var januaryData =
                temperatureData['January'] as Map<String, dynamic>;
            var julyData = temperatureData['July'] as Map<String, dynamic>;
            var januaryRange = TemperatureRange(
              min: januaryData['min'],
              max: januaryData['max'],
            );
            var julyRange = TemperatureRange(
              min: julyData['min'],
              max: julyData['max'],
            );
            provinces.add(Province(
              name: provinceName,
              months: {
                'January': januaryRange,
                'July': julyRange,
              },
            ));
          }
        });
      }
      //print(provinces[0].name);
      _provinces = provinces;
      notifyListeners();

      return provinces;
    } catch (error) {
      print('Error fetching provinces: $error');
      // Handle the error if needed
      return []; // Return an empty list or handle the error in an appropriate way
    }
  }
}

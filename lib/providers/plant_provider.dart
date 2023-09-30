import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gardenguru/models/plant.dart';

class PlantProvider extends ChangeNotifier {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  List<Plant> _plants = [];

  List<Plant> get plants => _plants;

  Future<List<Plant>> fetchPlants() async {
    try {
      DatabaseEvent event = await _database.child('plants').once();
      List<Plant> plants = [];

      List<dynamic> dataList = event.snapshot.value as List<dynamic>;
      if (dataList != null) {
        dataList.forEach((data) {
          if (data is Map<dynamic, dynamic>) {
            plants.add(Plant.fromMap(data));
          }
        });
      }

      _plants = plants;
      notifyListeners();
      return plants; // Return the list of plants here
    } catch (error) {
      print('Error fetching plants: $error');
      // Handle the error if needed
      return []; // Return an empty list or handle the error in an appropriate way
    }
  }
}

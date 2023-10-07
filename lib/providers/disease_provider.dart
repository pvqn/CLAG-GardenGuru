import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gardenguru/models/disease.dart';

class DiseaseProvider extends ChangeNotifier {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  List<Disease> _plants = [];

  List<Disease> get plants => _plants;

  Future<List<Disease>> fetchDiseases() async {
    try {
      DatabaseEvent event = await _database.child('diseases').once();
      List<Disease> plants = [];

      List<dynamic> dataList = event.snapshot.value as List<dynamic>;
      if (dataList != null) {
        dataList.forEach((data) {
          if (data is Map<dynamic, dynamic>) {
            plants.add(Disease.fromMap(data));
          }
        });
      }

      _plants = plants;
      notifyListeners();
      return plants; // Return the list of plants here
    } catch (error) {
      print('Error fetching diseases: $error');
      // Handle the error if needed
      return []; // Return an empty list or handle the error in an appropriate way
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';

class MaintenanceProvider extends ChangeNotifier {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  Future<List<String>> fetchTips() async {
    try {
      DatabaseEvent event = await _database.child('maintenance').once();
      List<String> tips = [];

      List<dynamic> dataList = event.snapshot.value as List<dynamic>;
      if (dataList != null) {
        dataList.forEach((data) {
          tips.add(data);
        });
      }

      notifyListeners();
      return tips; // Return the list of plants here
    } catch (error) {
      print('Error fetching plants: $error');
      // Handle the error if needed
      return []; // Return an empty list or handle the error in an appropriate way
    }
  }
}

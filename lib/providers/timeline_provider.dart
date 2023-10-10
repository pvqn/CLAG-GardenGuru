import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:gardenguru/models/timeline.dart';
import 'package:flutter/foundation.dart';

class TimelineProvider extends ChangeNotifier {
  List<TimelineItem> _timelineItems = [];

  List<TimelineItem> get timelineItems => _timelineItems;

  Future<List<TimelineItem>> fetchTimelineItems() async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.reference().child('timeline');

      DatabaseEvent databaseEvent = await databaseReference.once();

      var timelineData = databaseEvent.snapshot.value;

      if (timelineData != null) {
        List<TimelineItem> fetchedItems = [];

        if (timelineData is Map) {
          // Handle the case where data is a map
          timelineData.forEach((key, value) {
            fetchedItems.add(TimelineItem.fromMap({
              'id': int.parse(key),
              'name': value['name'],
              'timeline': LinkedHashMap<String, String>.from(value['timeline']),
            }));
          });
        } else if (timelineData is List) {
          // Handle the case where data is a list
          // Assuming each item in the list has an 'id' key
          for (var item in timelineData) {
            fetchedItems.add(TimelineItem.fromMap({
              'id': item['id'],
              'name': item['name'],
              'timeline': LinkedHashMap<String, String>.from(item['timeline']),
            }));
          }
        }

        _timelineItems = fetchedItems;
        notifyListeners();
      }
    } catch (error) {
      print('Error fetching timeline items: $error');
      // Handle the error if needed, e.g., set an error state or show a message to the user
    }
    return _timelineItems;
  }
}

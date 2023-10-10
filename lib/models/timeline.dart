import 'package:flutter/foundation.dart';
import 'dart:collection'; // Import the dart:collection library

class TimelineItem {
  final int id;
  final String name;
  LinkedHashMap<String, String> timeline;

  TimelineItem({
    required this.id,
    required this.name,
    required this.timeline,
  });

  factory TimelineItem.fromMap(Map<dynamic, dynamic> map) {
    return TimelineItem(
      id: map['id'],
      name: map['name'],
      timeline: LinkedHashMap<String, String>.from(map['timeline']),
    );
  }
}

void reorderTimelineItems(TimelineItem item) {
  var orderedTimeline = SplayTreeMap<int, String>();

  item.timeline.forEach((key, value) {
    var day = int.tryParse(key.replaceAll('Day ', ''));
    if (day != null) {
      orderedTimeline[day] = value;
    }
  });

  item.timeline = LinkedHashMap.from(orderedTimeline.map((key, value) {
    return MapEntry('Day $key', value);
  }));
}

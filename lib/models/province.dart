class Province {
  late String name;
  late Map<String, TemperatureRange> months;

  Province({required this.name, required this.months});

  factory Province.fromMap(Map<dynamic, dynamic> map) {
    var monthsMap = map['months'] as Map<String, dynamic>;
    var monthsData = monthsMap
        .map((key, value) => MapEntry(key, TemperatureRange.fromMap(value)));

    return Province(
      name: map['name'],
      months: monthsData,
    );
  }
}

class TemperatureRange {
  late int min;
  late int max;

  TemperatureRange({required this.min, required this.max});

  factory TemperatureRange.fromMap(Map<dynamic, dynamic> map) {
    return TemperatureRange(
      min: map['min'],
      max: map['max'],
    );
  }
}

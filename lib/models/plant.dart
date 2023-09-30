class Plant {
  int id;
  String name;
  String description;
  String type;
  String soil;
  String position;
  String feeding;
  String plantingMaterial;
  String spacing;
  List<String> plantingSteps;
  Map<String, int> temperature;
  String temperatureUnit;
  Map<String, int> growingDuration;
  String growingTimeUnit;

  Plant({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.soil,
    required this.position,
    required this.feeding,
    required this.plantingMaterial,
    required this.spacing,
    required this.plantingSteps,
    required this.temperature,
    required this.temperatureUnit,
    required this.growingDuration,
    required this.growingTimeUnit,
  });

  factory Plant.fromMap(Map<dynamic, dynamic> map) {
    return Plant(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      type: map['type'],
      soil: map['soil'],
      position: map['position'],
      feeding: map['feeding'],
      plantingMaterial: map['planting_material'],
      spacing: map['spacing'],
      plantingSteps: List<String>.from(map['planting_steps']),
      temperature: Map<String, int>.from(map['temperature']),
      temperatureUnit: map['temperature_unit'],
      growingDuration: Map<String, int>.from(map['growing_duration']),
      growingTimeUnit: map['growing_time_unit'],
    );
  }
}

class Disease {
  final int index;
  final String diseaseName;
  final String description;
  final String possibleSteps;

  Disease({
    required this.index,
    required this.diseaseName,
    required this.description,
    required this.possibleSteps,
  });

  factory Disease.fromMap(Map<dynamic, dynamic> map) {
    return Disease(
      index: map['index'],
      diseaseName: map['disease_name'],
      description: map['description'],
      possibleSteps: map['Possible Steps'],
    );
  }
}

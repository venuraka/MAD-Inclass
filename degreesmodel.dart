class Degree {
  String id;
  String name;
  String duration;

  Degree({required this.id, required this.name, required this.duration});

  Map<String, dynamic> toMap() {
    return {"name": name, "duration": duration};
  }

  factory Degree.fromMap(Map<String, dynamic> data, String documentId) {
    return Degree(
      id: documentId,
      name: data['name'] ?? '',
      duration: data['duration'] ?? '',
    );
  }
}
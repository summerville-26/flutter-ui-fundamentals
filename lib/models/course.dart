// I Komang Candra Aryadinata || 2415051085
class Course {
  final String id;
  final String title;
  final String code;
  final String status;
  final String description;

  Course({
    required this.id,
    required this.title,
    required this.code,
    required this.status,
    required this.description,
  });

  // Mengubah JSON menjadi objek Course.
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'].toString(),
      title: json['title'] as String,
      code: json['code'] as String,
      status: json['status'] as String,
      description: json['description'] as String,
    );
  }

  // Mengubah objek Course menjadi JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'code': code,
      'status': status,
      'description': description,
    };
  }
}

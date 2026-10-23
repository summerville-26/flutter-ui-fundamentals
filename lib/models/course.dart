//I Komang Camdra Aryadinata || 2415051085
class Course {
  final int? id;
  final String code;
  final String title;
  final int credits;
  final String status;
  final String? createdAt;

  const Course({
    this.id,
    required this.code,
    required this.title,
    required this.credits,
    this.status = 'planned',
    this.createdAt,
  });

  // Mengubah JSON menjadi objek Course.
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] == null ? null : (json['id'] as num).toInt(),
      code: json['code'] as String,
      title: json['title'] as String,
      credits: (json['credits'] as num).toInt(),
      status: (json['status'] as String?) ?? 'planned',
      createdAt: json['created_at'] as String?,
    );
  }

  // Mengubah objek Course menjadi JSON.
  Map<String, dynamic> toJson() {
    return {'code': code, 'title': title, 'credits': credits, 'status': status};
  }
}

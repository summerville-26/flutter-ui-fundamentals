import '../models/course.dart';

// I Komang Candra Aryadinata || 2415051085
class CourseService {
  Future<List<Course>> fetchCourses() async {
    // Simulasi pengambilan data JSON
    final List<Map<String, dynamic>> jsonData = [
      {
        'id': '1',
        'title': 'Pemrograman Flutter',
        'code': 'IF101',
        'status': 'Sedang Dipelajari',
        'description': 'Belajar membuat aplikasi menggunakan Flutter.',
      },
      {
        'id': '2',
        'title': 'Desain UI/UX',
        'code': 'IF102',
        'status': 'Belum Dimulai',
        'description': 'Belajar merancang antarmuka dan pengalaman pengguna.',
      },
      {
        'id': '3',
        'title': 'Basis Data',
        'code': 'IF103',
        'status': 'Sedang Dipelajari',
        'description': 'Belajar mengelola dan merancang basis data.',
      },
      {
        'id': '4',
        'title': 'Pemrograman Web',
        'code': 'IF104',
        'status': 'Selesai',
        'description': 'Belajar dasar pengembangan aplikasi web.',
      },
      {
        'id': '5',
        'title': 'Jaringan Komputer',
        'code': 'IF105',
        'status': 'Belum Dimulai',
        'description': 'Belajar konsep dasar jaringan komputer.',
      },
    ];

    // Mengubah data JSON menjadi objek Course
    return jsonData.map((json) => Course.fromJson(json)).toList();
  }
}

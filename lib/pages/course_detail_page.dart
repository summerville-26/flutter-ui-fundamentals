import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../main.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import 'edit_course_page.dart';

// I Komang Candra Aryadinata || 2415051085
class CourseDetailPage extends StatefulWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  bool _showDescription = true;
  late Course _course;

  @override
  void initState() {
    super.initState();
    _course = widget.course;
  }

  Future<void> _openEditPage() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => EditCoursePage(course: _course)),
    );

    if (!mounted) return;

    if (result == true) {
      final provider = context.read<CourseProvider>();

      // Cari data terbaru berdasarkan kode course.
      final updatedCourse = provider.courses
          .where((course) => course.code == _course.code)
          .firstOrNull;

      if (updatedCourse != null) {
        setState(() {
          _course = updatedCourse;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data course berhasil diperbarui.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();
    final isFavorite = courseState.isFavorite(_course.code);

    return Scaffold(
      appBar: AppBar(title: Text(_course.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _course.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Kode: ${_course.code}'),
            Text('Status: ${_course.status}'),
            const Divider(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Informasi Course',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _showDescription = !_showDescription;
                    });
                  },
                  icon: Icon(
                    _showDescription ? Icons.visibility_off : Icons.visibility,
                  ),
                  label: Text(_showDescription ? 'Sembunyikan' : 'Tampilkan'),
                ),
              ],
            ),

            if (_showDescription) ...[
              Text(
                'Kode Mata Kuliah: ${_course.code}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Jumlah SKS: ${_course.credits}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Status: ${_course.status}',
                style: const TextStyle(fontSize: 16),
              ),
            ],

            const SizedBox(height: 24),

            // Tombol Edit Course
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _openEditPage,
                icon: const Icon(Icons.edit),
                label: const Text('Edit Course'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Tombol Favorit
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                context.read<CourseState>().toggleFavorite(_course.code);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isFavorite
                          ? 'Dihapus dari favorit'
                          : 'Ditambahkan ke favorit oleh $studentName',
                    ),
                  ),
                );
              },
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              label: Text(isFavorite ? 'Hapus Favorit' : 'Tambah Favorit'),
            ),

            const SizedBox(height: 30),

            const Text(
              'Pengembang: $studentName ($studentId)',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

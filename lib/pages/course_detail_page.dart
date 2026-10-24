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

  // Membuka halaman Edit Course.
  Future<void> _openEditPage() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => EditCoursePage(course: _course)),
    );

    if (!mounted) return;

    if (result == true) {
      final provider = context.read<CourseProvider>();

      // Mencari data course terbaru berdasarkan kode.
      Course? updatedCourse;

      for (final course in provider.courses) {
        if (course.code == _course.code) {
          updatedCourse = course;
          break;
        }
      }

      if (updatedCourse != null) {
        setState(() {
          _course = updatedCourse!;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data course berhasil diperbarui.')),
      );
    }
  }

  // Menampilkan konfirmasi sebelum menghapus course.
  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Course?'),
          content: Text(
            'Apakah kamu yakin ingin menghapus '
            '"${_course.title}"? '
            'Tindakan ini tidak dapat dibatalkan.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              icon: const Icon(Icons.delete),
              label: const Text('Hapus'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );

    // Hentikan proses jika dibatalkan atau halaman sudah ditutup.
    if (!mounted || confirmed != true) return;

    final courseId = _course.id;

    if (courseId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Course tidak memiliki ID.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final courseProvider = context.read<CourseProvider>();
    final courseState = context.read<CourseState>();

    // Simpan status favorit sebelum course dihapus.
    final wasFavorite = courseState.isFavorite(_course.code);

    try {
      // Menghapus course melalui API dan memperbarui daftar.
      await courseProvider.deleteCourse(courseId);

      if (!mounted) return;

      // Hapus dari favorit jika sebelumnya merupakan favorit.
      if (wasFavorite) {
        courseState.toggleFavorite(_course.code);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Course berhasil dihapus.'),
          backgroundColor: Colors.green,
        ),
      );

      // Kembali ke halaman sebelumnya setelah berhasil.
      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus course: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();
    final isFavorite = courseState.isFavorite(_course.code);
    final isSaving = context.watch<CourseProvider>().isSaving;

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

            // Informasi Course.
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

            // Tombol Edit Course.
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isSaving ? null : _openEditPage,
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

            // Tombol Favorit.
            // Tombol Favorit.
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
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
            ),

            const SizedBox(height: 12),

            // Tombol Hapus Course.
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isSaving ? null : _confirmDelete,
                icon: const Icon(Icons.delete),
                label: const Text('Hapus Course'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 12),

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

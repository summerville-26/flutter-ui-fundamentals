import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../main.dart';
import '../models/course.dart';

// I Komang Candra Aryadinata || 2415051085
class CourseDetailPage extends StatefulWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  bool _showDescription = true;

  @override
  Widget build(BuildContext context) {
    // Mengambil shared state dari Provider yang sama dengan CoursesPage
    final courseState = context.watch<CourseState>();
    final isFavorite = courseState.favorites.contains(widget.course.id);

    return Scaffold(
      appBar: AppBar(title: Text(widget.course.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.course.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Kode: ${widget.course.code} | '
              'Status: ${widget.course.status}',
            ),
            const Divider(height: 32),

            // Deskripsi dapat ditampilkan atau disembunyikan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Deskripsi Course',
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
            if (_showDescription)
              Text(
                widget.course.description,
                style: const TextStyle(fontSize: 16),
              ),

            const SizedBox(height: 24),

            // Shared Favorites: status mengikuti Provider
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                context.read<CourseState>().toggleFavorite(widget.course.id);

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

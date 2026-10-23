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
    // Gunakan kode course sebagai kunci favorit.
    final courseState = context.watch<CourseState>();
    final isFavorite = courseState.isFavorite(widget.course.code);

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
            Text('Kode: ${widget.course.code}'),
            Text('Status: ${widget.course.status}'),
            const Divider(height: 32),

            // Informasi diambil dari data course yang tersedia.
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
                'Kode Mata Kuliah: ${widget.course.code}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Jumlah SKS: ${widget.course.credits}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Status: ${widget.course.status}',
                style: const TextStyle(fontSize: 16),
              ),
            ],

            const SizedBox(height: 24),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                context.read<CourseState>().toggleFavorite(widget.course.code);

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

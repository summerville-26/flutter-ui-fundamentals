import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import '../widgets/error_view.dart';
import 'course_detail_page.dart';
import 'add_course_page.dart';

// I Komang Candra Aryadinata || 2415051085
const String studentName = 'I Komang Candra Aryadinata';
const String studentId = '2415051085';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  String _searchQuery = '';

  Future<void> _openAddCourse() async {
    final provider = context.read<CourseProvider>();

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const AddCoursePage()),
    );

    if (!mounted) return;

    if (result == true) {
      await provider.loadCourses();
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();
    final courseProvider = context.watch<CourseProvider>();

    final filteredCourses = courseProvider.courses.where((course) {
      final query = _searchQuery.toLowerCase();

      return course.title.toLowerCase().contains(query) ||
          course.code.toLowerCase().contains(query);
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 600;

        final int crossAxisCount = width >= 1100
            ? 3
            : width >= 650
            ? 2
            : 1;

        return ColoredBox(
          color: const Color(0xFFF3F7FC),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 8 : 18),
                child: Column(
                  children: [
                    // Header lebih ringkas pada HP.
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 14 : 20,
                        vertical: isMobile ? 11 : 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(14),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.school_rounded,
                            color: Colors.white,
                            size: isMobile ? 22 : 28,
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              'Course Data Manager',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 17 : 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Area konten utama.
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(isMobile ? 10 : 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(14),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Identitas mahasiswa dibuat ringkas.
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: isMobile ? 8 : 12,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF4FA),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.badge_outlined,
                                    color: Color(0xFF28527A),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '$studentId • $studentName',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: const Color(0xFF28527A),
                                        fontWeight: FontWeight.w600,
                                        fontSize: isMobile ? 11 : 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: isMobile ? 10 : 16),

                            // Pada HP, pencarian dan tambah berada satu baris.
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: isMobile ? 42 : 48,
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          _searchQuery = value;
                                        });
                                      },
                                      style: const TextStyle(fontSize: 14),
                                      decoration: InputDecoration(
                                        hintText: 'Cari nama atau kode...',
                                        hintStyle: const TextStyle(
                                          fontSize: 13,
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.search_rounded,
                                          color: Color(0xFF1976D2),
                                          size: 21,
                                        ),
                                        suffixIcon: _searchQuery.isNotEmpty
                                            ? IconButton(
                                                tooltip: 'Hapus pencarian',
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  setState(() {
                                                    _searchQuery = '';
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.close_rounded,
                                                  size: 18,
                                                ),
                                              )
                                            : null,
                                        filled: true,
                                        fillColor: const Color(0xFFF6F9FD),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFD8E4F0),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFD8E4F0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF1976D2),
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),

                                if (isMobile)
                                  SizedBox(
                                    height: 42,
                                    width: 44,
                                    child: IconButton.filled(
                                      tooltip: 'Tambah Course',
                                      onPressed: _openAddCourse,
                                      icon: const Icon(Icons.add_rounded),
                                      style: IconButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF1976D2,
                                        ),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  FilledButton.icon(
                                    onPressed: _openAddCourse,
                                    icon: const Icon(Icons.add_rounded),
                                    label: const Text('Tambah Course'),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: const Color(0xFF1976D2),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            SizedBox(height: isMobile ? 8 : 14),

                            // Favorites diringkas menjadi baris pendek.
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 11,
                                vertical: isMobile ? 7 : 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0F6FD),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFD9E8F8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.favorite_rounded,
                                    color: Color(0xFF1976D2),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  const Expanded(
                                    child: Text(
                                      'Favorites',
                                      style: TextStyle(
                                        color: Color(0xFF24476A),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${courseState.favorites.length}',
                                    style: const TextStyle(
                                      color: Color(0xFF1976D2),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.favorite_border_rounded,
                                    size: 17,
                                    color: Color(0xFF1976D2),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: isMobile ? 10 : 18),

                            // Judul daftar.
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Daftar Mata Kuliah',
                                    style: TextStyle(
                                      fontSize: isMobile ? 15 : 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF203A56),
                                    ),
                                  ),
                                ),
                                Text(
                                  '${filteredCourses.length} course',
                                  style: const TextStyle(
                                    color: Color(0xFF60758B),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: isMobile ? 6 : 12),

                            // Daftar mengambil semua ruang tersisa.
                            Expanded(
                              child: _buildCourseContent(
                                courseProvider,
                                filteredCourses,
                                crossAxisCount,
                                courseState,
                                isMobile,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCourseContent(
    CourseProvider provider,
    List<Course> courses,
    int crossAxisCount,
    CourseState courseState,
    bool isMobile,
  ) {
    if (provider.isLoading && provider.courses.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(height: 10),
            Text('Memuat data mata kuliah...'),
          ],
        ),
      );
    }

    if (provider.hasError && provider.courses.isEmpty) {
      return ErrorView(
        message: provider.errorMessage ?? 'Terjadi kesalahan.',
        onRetry: provider.loadCourses,
      );
    }

    if (provider.courses.isEmpty) {
      return _buildEmptyState(
        icon: Icons.menu_book_rounded,
        title: 'Belum ada mata kuliah',
        subtitle: 'Tambahkan course pertama untuk mulai mengelola data.',
      );
    }

    if (courses.isEmpty) {
      return _buildEmptyState(
        icon: Icons.search_off_rounded,
        title: 'Course tidak ditemukan',
        subtitle: 'Coba nama atau kode course yang berbeda.',
      );
    }

    return Column(
      children: [
        if (provider.isLoading)
          const LinearProgressIndicator(color: Colors.blue, minHeight: 2),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.only(bottom: 8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              // Kartu cukup tinggi untuk teks dan tombol aksi.
              childAspectRatio: crossAxisCount == 1
                  ? (isMobile ? 2.6 : 3.0)
                  : 1.65,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              final isFavorite = courseState.favorites.contains(course.code);

              return CourseCard(
                course: course,
                isFavorite: isFavorite,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CourseDetailPage(course: course),
                    ),
                  );
                },
                onFavoriteToggle: () {
                  context.read<CourseState>().toggleFavorite(course.code);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: const Color(0xFF8AA6C1)),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF24476A),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF60758B), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

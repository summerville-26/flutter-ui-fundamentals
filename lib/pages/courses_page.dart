import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import '../widgets/favorite_widgets.dart';
import 'course_detail_page.dart';
import '../widgets/error_view.dart';
import 'add_course_page.dart';

// I Komang Candra Aryadinata || 2415051085
class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  String _searchQuery = '';
  bool _demoFavorite = false;

  final ValueNotifier<int> _favoriteCounter = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CourseProvider>().loadCourses();
      }
    });
  }

  void _toggleDemoFavorite() {
    setState(() {
      _demoFavorite = !_demoFavorite;
    });
  }

  @override
  void dispose() {
    _favoriteCounter.dispose();
    super.dispose();
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
        int crossAxisCount = 1;

        if (constraints.maxWidth >= 840) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth >= 600) {
          crossAxisCount = 2;
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() => _searchQuery = value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search courses...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.blue.withValues(alpha: 0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    tooltip: 'Tambah Course',
                    onPressed: () async {
                      // Ambil provider sebelum proses await.
                      final courseProvider = context.read<CourseProvider>();

                      final result = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddCoursePage(),
                        ),
                      );

                      // Pastikan halaman masih aktif.
                      if (!mounted) return;

                      // Muat ulang daftar jika course berhasil ditambahkan.
                      if (result == true) {
                        await courseProvider.loadCourses();
                      }
                    },
                    icon: const Icon(Icons.add),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Demo local state
              Row(
                children: [
                  Expanded(
                    child: FavoriteToggleChild(
                      isFavorite: _demoFavorite,
                      onToggle: _toggleDemoFavorite,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FavoriteStatusChild(isFavorite: _demoFavorite),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Shared Favorites
              Card(
                color: Colors.blue.shade50,
                child: ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.blue),
                  title: const Text('Shared Favorites'),
                  subtitle: const Text(
                    'Favorit dibagikan ke halaman daftar dan detail.',
                  ),
                  trailing: Text(
                    '${courseState.favorites.length}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              Consumer<CourseState>(
                builder: (context, state, child) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.favorite_border,
                        color: Colors.blue,
                      ),
                      title: const Text('Consumer: Jumlah Favorit'),
                      trailing: Text(
                        '${state.favoriteCount}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Loading, error, dan success state
              Expanded(
                child: _buildCourseContent(
                  courseProvider,
                  filteredCourses,
                  crossAxisCount,
                  courseState,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //I Komang Candra Aryadinata || 2415051085
  Widget _buildCourseContent(
    CourseProvider provider,
    List<Course> courses,
    int crossAxisCount,
    CourseState courseState,
  ) {
    // 1. Loading: tampilkan indikator saat data pertama kali dimuat.
    if (provider.isLoading && provider.courses.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(height: 12),
            Text('Memuat data mata kuliah...'),
          ],
        ),
      );
    }

    // 2. Error: tampilkan pesan dan tombol retry.
    if (provider.hasError && provider.courses.isEmpty) {
      return ErrorView(
        message: provider.errorMessage ?? 'Terjadi kesalahan.',
        onRetry: provider.loadCourses,
      );
    }

    // 3. Success, tetapi API mengembalikan daftar kosong.
    if (provider.courses.isEmpty) {
      return const Center(child: Text('Data course belum tersedia'));
    }

    // 4. Pencarian tidak menemukan course.
    if (courses.isEmpty) {
      return const Center(child: Text('Course tidak ditemukan'));
    }

    // 5. Success: tampilkan daftar course.
    return Column(
      children: [
        if (provider.isLoading)
          const LinearProgressIndicator(color: Colors.blue),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 2.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
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
                      builder: (context) => CourseDetailPage(course: course),
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
}

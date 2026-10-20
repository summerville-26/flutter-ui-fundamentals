import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../data/course_data.dart';
import '../models/course.dart';
import '../widgets/course_card.dart';
import '../widgets/favorite_widgets.dart';
import 'course_detail_page.dart';

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

    final filteredCourses = dummyCourses.where((course) {
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
              TextField(
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
              const SizedBox(height: 12),
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
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Tahap 4: ValueNotifier',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ValueListenableBuilder<int>(
                        valueListenable: _favoriteCounter,
                        builder: (context, value, child) {
                          return Text(
                            'Jumlah: $value',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        tooltip: 'Tambah jumlah',
                        onPressed: () {
                          _favoriteCounter.value++;
                        },
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                color: Colors.blue.shade50,
                child: ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.blue),
                  title: const Text('Tahap 7: Provider Favorites'),
                  subtitle: const Text(
                    'Tekan ikon hati pada mata kuliah untuk mengubah status.',
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
                        '${state.favorites.length}',
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
              Expanded(
                child: filteredCourses.isEmpty
                    ? const Center(child: Text('Course tidak ditemukan'))
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: filteredCourses.length,
                        itemBuilder: (context, index) {
                          final Course course = filteredCourses[index];
                          final isFavorite = courseState.favorites.contains(
                            course.id,
                          );

                          return CourseCard(
                            course: course,
                            isFavorite: isFavorite,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CourseDetailPage(course: course),
                                ),
                              );
                            },
                            onFavoriteToggle: () {
                              context.read<CourseState>().toggleFavorite(
                                course.id,
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

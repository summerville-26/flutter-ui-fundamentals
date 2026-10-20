import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/course.dart';
import 'course_state.dart';

// I Komang Candra Aryadinata || 2415051085
const String studentName = 'I Komang Candra Aryadinata';
const String studentId = '2415051085';

// MODEL COURSE

// DATA COURSE STATIK
final List<Course> dummyCourses = [
  Course(
    id: '1',
    title: 'Responsive Layout',
    code: 'MOB04',
    status: 'Active',
    description: 'Mempelajari pembuatan layout adaptif menggunakan LayoutBuilder & MediaQuery.',
  ),
  Course(
    id: '2',
    title: 'Navigation',
    code: 'MOB05',
    status: 'Planned',
    description: 'Mempelajari navigasi multi-screen, Navigator.push, pop, dan passing data.',
  ),
  Course(
    id: '3',
    title: 'Interaction',
    code: 'MOB06',
    status: 'Planned',
    description: 'Mempelajari penanganan gestur user menggunakan InkWell dan GestureDetector.',
  ),
  Course(
    id: '4',
    title: 'Form & Input',
    code: 'MOB07',
    status: 'Upcoming',
    description:
        'Mempelajari pembuatan form, input validation, dan controller.',
  ),
  Course(
    id: '5',
    title: 'State Management',
    code: 'MOB08',
    status: 'Upcoming',
    description:
        'Mempelajari pengelolaan state aplikasi secara responsif dan efisien.',
  ),
  Course(
    id: '6',
    title: 'API Integration',
    code: 'MOB09',
    status: 'Upcoming',
    description: 'Mempelajari konsumsi REST API dan pemrosesan JSON.',
  ),
];

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CourseState(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const ResponsiveShell(),
    );
  }
}

// RESPONSIVE SHELL
class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [HomePage(), CoursesPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isExpanded = constraints.maxWidth >= 840;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Course Explorer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                color: Colors.blue.shade700,
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 4, left: 16),
                child: Text(
                  '$studentId - $studentName',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ),
          ),
          body: isExpanded
              ? Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (index) {
                        setState(() => _selectedIndex = index);
                      },
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.menu_book),
                          label: Text('Courses'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.person),
                          label: Text('Profile'),
                        ),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(child: _pages[_selectedIndex]),
                  ],
                )
              : _pages[_selectedIndex],
          bottomNavigationBar: isExpanded
              ? null
              : NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() => _selectedIndex = index);
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.menu_book),
                      label: 'Courses',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
        );
      },
    );
  }
}

// HOME PAGE
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang, $studentName!',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('NIM: $studentId'),
                  const SizedBox(height: 12),
                  const Text(
                    'Jelajahi modul pembelajaran interactive mobile development pada tab Courses.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Ringkasan Kursus',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.class_, color: Colors.blue),
            title: const Text('Total Course Available'),
            trailing: Text('${dummyCourses.length} Courses'),
          ),
        ],
      ),
    );
  }
}

// COURSES PAGE
class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  String _searchQuery = '';

  // Tahap 3: Local state pada parent.
  bool _demoFavorite = false;

  // Tahap 4: ValueNotifier.
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
    // I Komang Candra Aryadinata || 2415051085
    // Tahap 7: watch mendengarkan perubahan CourseState.
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

              // TAHAP 3: Lifting state up.
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

              // TAHAP 4: ValueNotifier.
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

              // TAHAP 7: context.watch().
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

              // TAHAP 7: Consumer.
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

              // DAFTAR COURSE
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
                          final course = filteredCourses[index];
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
                              // Tahap 7: context.read().
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

// CHILD TAHAP 3
class FavoriteToggleChild extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onToggle;

  const FavoriteToggleChild({
    super.key,
    required this.isFavorite,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Child 1: Kontrol Favorit',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            Text(isFavorite ? 'Status: Favorit' : 'Status: Bukan favorit'),
            TextButton(onPressed: onToggle, child: const Text('Ubah status')),
          ],
        ),
      ),
    );
  }
}

class FavoriteStatusChild extends StatelessWidget {
  final bool isFavorite;

  const FavoriteStatusChild({super.key, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Child 2: Tampilan Status',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            const Text(
              'Status mengikuti nilai dari parent.',
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

// COURSE CARD
class CourseCard extends StatelessWidget {
  final Course course;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const CourseCard({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.blue.shade100),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF0D253F),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.code,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Text(
                  course.status,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: course.status == 'Active'
                        ? Colors.teal
                        : Colors.teal.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                tooltip: isFavorite
                    ? 'Hapus dari favorit'
                    : 'Tambahkan ke favorit',
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: onFavoriteToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// DETAIL PAGE
class CourseDetailPage extends StatefulWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  // Tahap 1: local state untuk deskripsi.
  bool _showDescription = true;

  @override
  Widget build(BuildContext context) {
    // Tahap 7: watch untuk membaca status favorit.
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
              'Kode: ${widget.course.code} | Status: ${widget.course.status}',
            ),
            const Divider(height: 32),
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
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // read untuk menjalankan aksi favorit.
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
            Text(
              'Pengembang: $studentName ($studentId)',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

// PROFILE PAGE
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                studentName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('NIM: $studentId'),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Form Feedback',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const FeedbackFormWidget(),
        ],
      ),
    );
  }
}

// FEEDBACK FORM
class FeedbackFormWidget extends StatefulWidget {
  const FeedbackFormWidget({super.key});

  @override
  State<FeedbackFormWidget> createState() => _FeedbackFormWidgetState();
}

class _FeedbackFormWidgetState extends State<FeedbackFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi Feedback'),
        content: Text(
          'Kirim feedback dari $studentName ($studentId)?\n\n'
          'Isi: "${_commentController.text}"',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _commentController.clear();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Feedback berhasil dikirim! Terima kasih.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _commentController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Komentar / Feedback',
              border: OutlineInputBorder(),
              hintText: 'Tuliskan masukan Anda (minimal 5 karakter)...',
            ),
            validator: (value) {
              if (value == null || value.trim().length < 5) {
                return 'Komentar harus berisi minimal 5 karakter!';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: _submitForm,
              child: const Text('Kirim Feedback'),
            ),
          ),
        ],
      ),
    );
  }
}

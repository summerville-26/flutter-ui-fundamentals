//I Komang Candra Aryadinata || 2415051085
import 'package:flutter/material.dart';

// Identitas Mahasiswa
const String studentName = 'I Komang Candra Aryadinata';
const String studentId = '2415051085';

// Model Course
class Course {
  final String id;
  final String title;
  final String code;
  final String status;
  final String description;
  bool isFavorite;

  Course({
    required this.id,
    required this.title,
    required this.code,
    required this.status,
    required this.description,
    this.isFavorite = false,
  });
}

// Data Course Statik (Minimal 5 item)
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
  runApp(const CourseExplorerApp());
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

// Shell Utama Adaptif
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
        final bool isExpanded = constraints.maxWidth >= 840;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Course Explorer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20.0),
              child: Container(
                color: Colors.blue.shade700,
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
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
                      onDestinationSelected: (idx) =>
                          setState(() => _selectedIndex = idx),
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
                  onDestinationSelected: (idx) =>
                      setState(() => _selectedIndex = idx),
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

// -----------------------------------------------------------------------------
// 1. HOME PAGE (Tampilan Awal)
// -----------------------------------------------------------------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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

// -----------------------------------------------------------------------------
// 2. COURSES PAGE (Course Explore + Pencari)
// -----------------------------------------------------------------------------
class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredCourses = dummyCourses
        .where(
          (c) =>
              c.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              c.code.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;
        if (constraints.maxWidth >= 840) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth >= 600) {
          crossAxisCount = 2;
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar Fitur Pencari
              TextField(
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search courses...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.blue.shade50.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // List / Grid Adaptif
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
                          // REUSABLE WIDGET 1: CourseCard
                          return CourseCard(
                            course: course,
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CourseDetailPage(course: course),
                                ),
                              );
                              if (result != null) {
                                setState(() {});
                              }
                            },
                            onFavoriteToggle: () {
                              setState(() {
                                course.isFavorite = !course.isFavorite;
                              });
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

// -----------------------------------------------------------------------------
// REUSABLE WIDGET 1: CourseCard
// -----------------------------------------------------------------------------
class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const CourseCard({
    super.key,
    required this.course,
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Row(
                children: [
                  Text(
                    course.status,
                    style: TextStyle(
                      color: course.status == 'Active'
                          ? Colors.teal
                          : Colors.teal.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      course.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: course.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: onFavoriteToggle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// DETAIL PAGE (Passing Data Via Constructor)
// -----------------------------------------------------------------------------
class CourseDetailPage extends StatefulWidget {
  final Course course;
  const CourseDetailPage({super.key, required this.course});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.course.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
            Text(
              widget.course.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.course.isFavorite = !widget.course.isFavorite;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          widget.course.isFavorite
                              ? 'Ditambahkan ke favorit oleh $studentName'
                              : 'Dihapus dari favorit',
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    widget.course.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  label: Text(
                    widget.course.isFavorite ? 'Favorit' : 'Tambah Favorit',
                  ),
                ),
              ],
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

// -----------------------------------------------------------------------------
// 3. PROFILE PAGE (Form Feedback & Validasi)
// -----------------------------------------------------------------------------
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
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
          // REUSABLE WIDGET 2: FeedbackFormWidget
          const FeedbackFormWidget(),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// REUSABLE WIDGET 2: FeedbackFormWidget
// -----------------------------------------------------------------------------
class FeedbackFormWidget extends StatefulWidget {
  const FeedbackFormWidget({super.key});

  @override
  State<FeedbackFormWidget> createState() => _FeedbackFormWidgetState();
}

class _FeedbackFormWidgetState extends State<FeedbackFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Konfirmasi Feedback'),
          content: Text(
            'Kirim feedback dari $studentName ($studentId)?\n\nIsi: "${_commentController.text}"',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
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

import 'package:flutter/material.dart';

const String studentName = 'I Komang Candra Aryadinata';
const String studentId = '2415051085';

void main() {
  runApp(const CourseExplorerApp());
}

// ======================================================
// APP
// ======================================================

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      home: const MainNavigationPage(),
    );
  }
}

// ======================================================
// MAIN NAVIGATION
// ======================================================

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [HomeTab(), CoursesTab(), ProfileTab()];

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isExpanded = constraints.maxWidth >= 840;

          // ============================================
          // EXPANDED
          // NavigationRail di sebelah kiri
          // ============================================

          if (isExpanded) {
            return Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: changePage,
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.menu_book_outlined),
                      selectedIcon: Icon(Icons.menu_book),
                      label: Text('Courses'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),

                const VerticalDivider(width: 1),

                Expanded(child: pages[selectedIndex]),
              ],
            );
          }
          //I Komang Candra Aryadinata || 2415051085
          // ============================================
          // COMPACT & MEDIUM
          // NavigationBar di bagian bawah
          // ============================================

          return pages[selectedIndex];
        },
      ),

      // NavigationBar hanya muncul pada Compact
      // dan Medium.
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 840) {
            return const SizedBox.shrink();
          }

          return NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: changePage,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                selectedIcon: Icon(Icons.menu_book),
                label: 'Courses',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}

// ======================================================
// HOME TAB
// ======================================================

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Explorer')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.school, size: 80),

              const SizedBox(height: 20),

              const Text(
                'Selamat Datang!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              const Text(
                'Temukan dan pelajari berbagai course '
                'yang tersedia di Course Explorer.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              Text('$studentId - $studentName', textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================================
// COURSES TAB
// ======================================================

class CoursesTab extends StatelessWidget {
  const CoursesTab({super.key});

  final List<Map<String, dynamic>> courses = const [
    {
      'title': 'Flutter Dasar',
      'code': 'FL001',
      'credits': 3,
      'status': 'Aktif',
    },
    {
      'title': 'Pemrograman Dart',
      'code': 'DT001',
      'credits': 3,
      'status': 'Aktif',
    },
    {'title': 'UI/UX Design', 'code': 'UX001', 'credits': 2, 'status': 'Aktif'},
    {'title': 'Basis Data', 'code': 'DB001', 'credits': 3, 'status': 'Aktif'},
    {
      'title': 'Jaringan Komputer',
      'code': 'JK001',
      'credits': 3,
      'status': 'Aktif',
    },
  ];

  Future<void> openCourse(
    BuildContext context,
    Map<String, dynamic> course,
  ) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => CourseDetailPage(course: course)),
    );

    if (result == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${course['title']} ditambahkan ke favorite')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Daftar Course',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          const Text('Pilih course untuk melihat detail.'),

          const SizedBox(height: 16),

          ...courses.map((course) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const Icon(Icons.menu_book, size: 30),
                title: Text(
                  course['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${course['code']} • '
                  '${course['credits']} SKS',
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  openCourse(context, course);
                },
              ),
            );
          }),

          const SizedBox(height: 16),

          const Divider(),

          const SizedBox(height: 12),

          Center(
            child: Text(
              '$studentId - $studentName',
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ======================================================
// PROFILE TAB
// ======================================================

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 45,
                child: Icon(Icons.person, size: 50),
              ),

              const SizedBox(height: 20),

              const Text(
                studentName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text('NIM: $studentId', textAlign: TextAlign.center),

              const SizedBox(height: 8),

              const Text('PTI 5A', textAlign: TextAlign.center),

              const SizedBox(height: 24),

              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Course Explorer',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Aplikasi eksplorasi course '
                        'berbasis Flutter.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================================
// COURSE DETAIL PAGE
// ======================================================

class CourseDetailPage extends StatefulWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.school, size: 70),

            const SizedBox(height: 18),

            Text(
              course['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.code),
                      title: const Text('Kode Course'),
                      subtitle: Text(course['code']),
                    ),

                    const Divider(),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.school),
                      title: const Text('SKS'),
                      subtitle: Text('${course['credits']} SKS'),
                    ),

                    const Divider(),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.check_circle),
                      title: const Text('Status'),
                      subtitle: Text(course['status']),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text('$studentId - $studentName', textAlign: TextAlign.center),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                label: Text(isFavorite ? 'Favorite' : 'Tambah Favorite'),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context, isFavorite);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

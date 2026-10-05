import 'package:flutter/material.dart';

const String studentName = 'I Komang Candra Aryadinata';
const String studentId = '2415051085';

void main() {
  runApp(const CourseExplorerApp());
}

// =====================================================
// APP
// =====================================================

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainNavigationPage(),
    );
  }
}

// =====================================================
// MAIN NAVIGATION
// =====================================================

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
          final bool isExpanded = constraints.maxWidth >= 840;

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

          return pages[selectedIndex];
        },
      ),

      // NavigationBar untuk layar Compact/Medium
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

// =====================================================
// HOME
// =====================================================

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Explorer')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),

                const Icon(Icons.school, size: 80),

                const SizedBox(height: 20),

                const Text(
                  'Selamat Datang',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                const Text(
                  studentName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 8),

                const Text('NIM: 2415051085', style: TextStyle(fontSize: 16)),

                const SizedBox(height: 30),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: const [
                        Icon(Icons.menu_book, size: 50),
                        SizedBox(height: 12),
                        Text(
                          'Course Explorer',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Aplikasi untuk menjelajahi '
                          'informasi mata kuliah.',
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
      ),
    );
  }
}

// =====================================================
// COURSES
// =====================================================

class CoursesTab extends StatelessWidget {
  const CoursesTab({super.key});

  static const List<Map<String, dynamic>> courses = [
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
    final bool? result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CourseDetailPage(course: course);
        },
      ),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 1;

          if (constraints.maxWidth >= 840) {
            crossAxisCount = 3;
          } else if (constraints.maxWidth >= 600) {
            crossAxisCount = 2;
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];

              return CourseCard(
                course: course,
                onTap: () {
                  openCourse(context, course);
                },
              );
            },
          );
        },
      ),
    );
  }
}

// =====================================================
// COURSE CARD
// =====================================================

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;
  final VoidCallback onTap;

  const CourseCard({super.key, required this.course, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.menu_book, size: 35),

              const SizedBox(height: 10),

              Text(
                course['title'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                '${course['code']} • '
                '${course['credits']} SKS',
              ),

              const Spacer(),

              Row(
                children: [
                  const Icon(Icons.circle, size: 10),
                  const SizedBox(width: 6),
                  Text(course['status']),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// PROFILE
// =====================================================

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 45,
                child: Icon(Icons.person, size: 50),
              ),

              const SizedBox(height: 15),

              const Text(
                studentName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 5),

              const Text('NIM: 2415051085', style: TextStyle(fontSize: 16)),

              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Feedback',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 15),

              const FeedbackForm(),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// FEEDBACK FORM
// =====================================================

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _nimController = TextEditingController();

  final TextEditingController _commentController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  // ===================================================
  // VALIDATE + SUBMIT
  // ===================================================

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulasi proses pengiriman
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) {
      return;
    }

    setState(() {
      isLoading = false;
    });

    // SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feedback berhasil dikirim!'),
        duration: Duration(seconds: 3),
      ),
    );

    _commentController.clear();
  }

  // ===================================================
  // ALERT DIALOG
  // ===================================================

  void showConfirmationDialog() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text(
            'Apakah Anda yakin ingin '
            'mengirim feedback?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                submitForm();
              },
              child: const Text('Kirim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // NAMA
          TextFormField(
            controller: _nameController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Nama tidak boleh kosong';
              }

              return null;
            },
          ),

          const SizedBox(height: 15),

          // NIM
          TextFormField(
            controller: _nimController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'NIM',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.badge),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'NIM tidak boleh kosong';
              }

              return null;
            },
          ),

          const SizedBox(height: 15),

          // KOMENTAR
          TextFormField(
            controller: _commentController,
            maxLines: 4,
            textInputAction: TextInputAction.newline,
            decoration: const InputDecoration(
              labelText: 'Komentar',
              hintText: 'Tulis komentar minimal 5 karakter',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.comment),
              alignLabelWithHint: true,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Komentar tidak boleh kosong';
              }

              if (value.trim().length < 5) {
                return 'Komentar minimal 5 karakter';
              }

              return null;
            },
          ),

          const SizedBox(height: 20),

          // BUTTON
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: isLoading ? null : showConfirmationDialog,
              icon: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              label: Text(isLoading ? 'Mengirim...' : 'Kirim Feedback'),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// COURSE DETAIL
// =====================================================

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
    final Map<String, dynamic> course = widget.course;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Course')),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.menu_book, size: 80),

              const SizedBox(height: 20),

              Text(
                course['title'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // COURSE INFORMATION
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.code),
                        title: const Text('Kode'),
                        subtitle: Text(course['code']),
                      ),
                      ListTile(
                        leading: const Icon(Icons.credit_card),
                        title: const Text('SKS'),
                        subtitle: Text('${course['credits']} SKS'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.check_circle),
                        title: const Text('Status'),
                        subtitle: Text(course['status']),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // IDENTITY
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data Mahasiswa',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(studentName),
                      Text('NIM: 2415051085'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // FAVORITE BUTTON
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFavorite
                            ? 'Course ditambahkan ke favorite'
                            : 'Course dihapus dari favorite',
                      ),
                    ),
                  );
                },
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                label: Text(isFavorite ? 'Favorite' : 'Tambah Favorite'),
              ),

              const SizedBox(height: 12),

              // INKWELL
              Material(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Course dipilih menggunakan InkWell'),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(18),
                    child: Center(
                      child: Text(
                        'Tekan area ini',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // GESTURE DETECTOR
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('GestureDetector: Tap terdeteksi'),
                    ),
                  );
                },
                onLongPress: () {
                  showDialog<void>(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Text('Long Press'),
                        content: const Text(
                          'Anda menekan area ini '
                          'cukup lama.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.touch_app),
                      SizedBox(height: 8),
                      Text(
                        'Tap atau Long Press',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // BACK
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, isFavorite);
                },
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

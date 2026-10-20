import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course_state.dart';
import 'pages/home_page.dart';
import 'pages/courses_page.dart';
import 'pages/profile_page.dart';
import 'providers/course_provider.dart';

// I Komang Candra Aryadinata || 2415051085
const String studentName = 'I Komang Candra Aryadinata';
const String studentId = '2415051085';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CourseState()),
        ChangeNotifierProvider(create: (context) => CourseProvider()),
      ],
      child: const CourseExplorerApp(),
    ),
  );
}

class ProviderDebugWidget extends StatelessWidget {
  const ProviderDebugWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Sengaja salah: context ini berada di atas Provider.
    final state = context.watch<CourseState>();

    return Text('Jumlah favorit: ${state.favoriteCount}');
  }
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
                width: double.infinity,
                color: Colors.blue.shade700,
                padding: const EdgeInsets.only(bottom: 4, left: 16),
                child: const Text(
                  '$studentId - $studentName',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
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

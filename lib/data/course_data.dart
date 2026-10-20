import '../models/course.dart';

// I Komang Candra Aryadinata || 2415051085
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

import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/profile_service.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProfileService _profileService = ProfileService();

  late Future<UserProfile?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _profileService.getMyProfile();
  }

  Future<void> _logout() async {
    try {
      await AuthService.instance.logout();

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal logout: $e')));
    }
  }

  Widget _buildProfile(UserProfile profile) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.account_circle, size: 80, color: Colors.indigo),
            const SizedBox(height: 16),
            const Text(
              'Informasi Pengguna',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildInfo('Nama', profile.name.isEmpty ? '-' : profile.name),
            _buildInfo('Email', profile.email),
            _buildInfo('Role', profile.role.toUpperCase()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Text(': '),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KosFinder'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<UserProfile?>(
          future: _profileFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text(
                'Gagal mengambil profil: ${snapshot.error}',
                textAlign: TextAlign.center,
              );
            }

            final profile = snapshot.data;

            if (profile == null) {
              return const Text('Data profil pengguna tidak ditemukan.');
            }

            return _buildProfile(profile);
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/profile_service.dart';
import '../widgets/role_guard.dart';
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfile?>(
      future: _profileFuture,
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final p = snap.data;

        if (snap.hasError || p == null) {
          return const Scaffold(
            body: Center(child: Text('Gagal memuat profil')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('KosFinder (${p.role})'),
            actions: [
              IconButton(
                tooltip: 'Logout',
                icon: const Icon(Icons.logout),
                onPressed: _logout,
              ),
            ],
          ),

          body: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(p.name.isEmpty ? p.email : p.name),
                subtitle: Text('${p.email} • ${p.role}'),
              ),

              const Divider(),

              const ListTile(
                leading: Icon(Icons.list),
                title: Text('Daftar Kos'),
                subtitle: Text('Melihat daftar kos yang tersedia'),
              ),

              const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Detail Kos'),
                subtitle: Text('Melihat informasi detail kos'),
              ),

              if (p.isOwner || p.isAdmin) ...[
                const Divider(),

                const ListTile(
                  leading: Icon(Icons.home_work),
                  title: Text('My Kos'),
                  subtitle: Text('Mengelola daftar kos milik Anda'),
                ),

                const ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit Kos'),
                  subtitle: Text('Mengubah informasi kos'),
                ),

                const ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete Kos'),
                  subtitle: Text('Menghapus data kos'),
                ),
              ],

              if (p.isAdmin) ...[
                const Divider(),

                const ListTile(
                  leading: Icon(Icons.admin_panel_settings),
                  title: Text('Kelola Data (Admin)'),
                  subtitle: Text('Pengelolaan data aplikasi'),
                ),
              ],
            ],
          ),

          floatingActionButton: RoleGuard(
            role: p.role,
            allowed: const ['owner', 'admin'],
            child: FloatingActionButton.extended(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur Add Kos belum dibuat.')),
                );
              },
              icon: const Icon(Icons.add_home),
              label: const Text('Tambah Kos'),
            ),
          ),
        );
      },
    );
  }
}

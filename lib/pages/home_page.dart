import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/auth_service.dart';
import '../services/profile_service.dart';
import '../services/kos_service.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProfileService _profileService = ProfileService();
  final KosService _kosService = KosService();

  late Future<UserProfile?> _profileFuture;
  late Future<List<Map<String, dynamic>>> _kosFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _profileService.getMyProfile();
    _kosFuture = _kosService.fetchAll();
  }

  // Memuat ulang daftar kos
  void _refreshKos() {
    setState(() {
      _kosFuture = _kosService.fetchAll();
    });
  }

  // Logout
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

  // CREATE: Menambahkan kos
  Future<void> _addKos() async {
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final priceController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Tambah Data Kos'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Kos',
                    hintText: 'Contoh: Kos Melati',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Alamat Kos',
                    hintText: 'Masukkan alamat kos',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Harga Kos',
                    hintText: 'Contoh: 500000',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final price = int.tryParse(priceController.text.trim());

                if (nameController.text.trim().isEmpty ||
                    addressController.text.trim().isEmpty ||
                    price == null ||
                    price <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Lengkapi semua data dan masukkan harga yang valid.',
                      ),
                    ),
                  );
                  return;
                }

                Navigator.pop(dialogContext, true);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      try {
        await _kosService.add(
          name: nameController.text.trim(),
          address: addressController.text.trim(),
          price: int.parse(priceController.text.trim()),
        );

        if (!mounted) return;

        _refreshKos();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data kos berhasil ditambahkan.')),
        );
      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gagal menambahkan kos: $e')));
      }
    }

    nameController.dispose();
    addressController.dispose();
    priceController.dispose();
  }

  // UPDATE: Mengubah data kos
  Future<void> _editKos(Map<String, dynamic> kos) async {
    final nameController = TextEditingController(
      text: kos['name']?.toString() ?? '',
    );

    final addressController = TextEditingController(
      text: kos['address']?.toString() ?? '',
    );

    final priceController = TextEditingController(
      text: kos['price']?.toString() ?? '',
    );

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Data Kos'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nama Kos'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Alamat Kos'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Harga Kos'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final price = int.tryParse(priceController.text.trim());

                if (nameController.text.trim().isEmpty ||
                    addressController.text.trim().isEmpty ||
                    price == null ||
                    price <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Lengkapi semua data dan masukkan harga yang valid.',
                      ),
                    ),
                  );
                  return;
                }

                Navigator.pop(dialogContext, true);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      try {
        final success = await _kosService.update(kos['id'].toString(), {
          'name': nameController.text.trim(),
          'address': addressController.text.trim(),
          'price': int.parse(priceController.text.trim()),
        });

        if (!mounted) return;

        if (success) {
          _refreshKos();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data kos berhasil diperbarui.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Perubahan ditolak oleh RLS atau data tidak ditemukan.',
              ),
            ),
          );
        }
      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gagal mengedit kos: $e')));
      }
    }

    nameController.dispose();
    addressController.dispose();
    priceController.dispose();
  }

  // DELETE: Menghapus data kos
  Future<void> _deleteKos(Map<String, dynamic> kos) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Data Kos'),
          content: Text('Apakah Anda yakin ingin menghapus ${kos['name']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      final success = await _kosService.delete(kos['id'].toString());

      if (!mounted) return;

      if (success) {
        _refreshKos();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data kos berhasil dihapus.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Penghapusan ditolak oleh RLS atau data tidak ditemukan.',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal menghapus kos: $e')));
    }
  }

  // SECURITY TEST: Menguji perlindungan RLS
  Future<void> _securityTest() async {
    const kosIdUserA = 'a1bb852e-494e-4a65-8974-176f99a81113';
    const ownerIdUserA = '53152417-480f-4a8c-a4bb-96e1da89971e';

    final results = <String>[];

    // 1. User B mencoba mengubah data milik User A
    try {
      final updated = await _kosService.update(kosIdUserA, {
        'name': 'DIUBAH USER B',
      });

      results.add(
        updated
            ? '[FAIL] User B berhasil mengubah data User A'
            : '[PASS] UPDATE ditolak oleh RLS',
      );
    } catch (e) {
      results.add('[PASS] UPDATE ditolak: $e');
    }

    // 2. User B mencoba menghapus data milik User A
    try {
      final deleted = await _kosService.delete(kosIdUserA);

      results.add(
        deleted
            ? '[FAIL] User B berhasil menghapus data User A'
            : '[PASS] DELETE ditolak oleh RLS',
      );
    } catch (e) {
      results.add('[PASS] DELETE ditolak: $e');
    }

    // 3. User B mencoba menambahkan kos atas nama User A
    try {
      await Supabase.instance.client.from('kos').insert({
        'owner_id': ownerIdUserA,
        'name': 'Kos Palsu',
        'address': 'Percobaan User B',
        'price': 500000,
      });

      results.add('[FAIL] INSERT atas nama User A berhasil');
    } on PostgrestException catch (e) {
      results.add('[PASS] INSERT ditolak: ${e.code} - ${e.message}');
    } catch (e) {
      results.add('[ERROR] INSERT: $e');
    }

    if (!mounted) return;

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hasil Security Testing'),
        content: SingleChildScrollView(child: Text(results.join('\n\n'))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );

    _refreshKos();
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

        final currentUserId = Supabase.instance.client.auth.currentUser?.id;

        return Scaffold(
          appBar: AppBar(
            title: Text('KosFinder (${p.role})'),
            actions: [
              IconButton(
                tooltip: 'Refresh',
                icon: const Icon(Icons.refresh),
                onPressed: _refreshKos,
              ),
              IconButton(
                tooltip: 'Logout',
                icon: const Icon(Icons.logout),
                onPressed: _logout,
              ),
              IconButton(
                tooltip: 'Security Test',
                icon: const Icon(Icons.security),
                onPressed: _securityTest,
              ),
            ],
          ),

          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Profil pengguna
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(p.name.isEmpty ? p.email : p.name),
                subtitle: Text('${p.email} • ${p.role}'),
              ),

              const Divider(),

              const Text(
                'Daftar Kos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // READ: Menampilkan data kos
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _kosFuture,
                builder: (context, kosSnap) {
                  if (kosSnap.connectionState != ConnectionState.done) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (kosSnap.hasError) {
                    return Text('Gagal memuat data kos: ${kosSnap.error}');
                  }

                  final kosList = kosSnap.data ?? [];

                  if (kosList.isEmpty) {
                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Belum ada data kos. Silakan tambahkan data kos.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: kosList.map((kos) {
                      final isMine =
                          kos['owner_id']?.toString() == currentUserId;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.home_work),
                          ),

                          title: Text(kos['name']?.toString() ?? 'Tanpa nama'),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                kos['address']?.toString() ??
                                    'Alamat belum tersedia',
                              ),
                              Text('Harga: Rp ${kos['price'] ?? 0}'),
                              Text(
                                isMine
                                    ? 'Kos milik Anda'
                                    : 'Kos milik pengguna lain',
                                style: TextStyle(
                                  color: isMine ? Colors.green : Colors.grey,
                                ),
                              ),
                            ],
                          ),

                          isThreeLine: true,

                          // Edit dan Hapus hanya untuk pemilik data
                          trailing: isMine
                              ? PopupMenuButton<String>(
                                  tooltip: 'Kelola Kos',
                                  icon: const Icon(Icons.more_vert),
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      _editKos(kos);
                                    } else if (value == 'delete') {
                                      _deleteKos(kos);
                                    }
                                  },
                                  itemBuilder: (context) => const [
                                    PopupMenuItem(
                                      value: 'edit',
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit, size: 18),
                                          SizedBox(width: 8),
                                          Text('Edit Kos'),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'delete',
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, size: 18),
                                          SizedBox(width: 8),
                                          Text('Hapus Kos'),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),

          // Tombol tambah hanya untuk Owner dan Admin
          floatingActionButton: (p.isOwner || p.isAdmin)
              ? FloatingActionButton.extended(
                  onPressed: _addKos,
                  icon: const Icon(Icons.add_home),
                  label: const Text('Tambah Kos'),
                )
              : null,
        );
      },
    );
  }
}

# Course Explorer v2

## 1. Deskripsi Aplikasi

Course Explorer v2 adalah aplikasi berbasis Flutter yang digunakan untuk mengelola dan menampilkan data mata kuliah. Aplikasi ini dikembangkan sebagai proyek praktikum untuk menerapkan konsep pengembangan antarmuka, responsive layout, navigasi, state management, serta integrasi backend.

Aplikasi menyediakan fitur untuk melihat daftar mata kuliah, mencari mata kuliah berdasarkan kode atau judul, melihat detail mata kuliah, menambahkan data baru, mengubah data, dan menghapus data. Aplikasi juga menyediakan fitur favorites untuk menandai mata kuliah pilihan.

Antarmuka dirancang agar dapat menyesuaikan ukuran layar, baik pada perangkat berukuran kecil maupun besar.

## 2. Teknologi yang Digunakan

- **Flutter** — framework pengembangan aplikasi.
- **Dart** — bahasa pemrograman.
- **Provider** — pengelolaan shared state dan state aplikasi.
- **Supabase** — backend untuk penyimpanan dan pengelolaan data mata kuliah.
- **PostgreSQL** — basis data yang digunakan oleh Supabase.
- **Git dan GitHub** — version control dan penyimpanan repository proyek.

## 3. Fitur Aplikasi

- Menampilkan daftar mata kuliah.
- Mencari mata kuliah berdasarkan kode atau judul.
- Menampilkan detail mata kuliah.
- Menambahkan mata kuliah.
- Mengubah data mata kuliah.
- Menghapus mata kuliah.
- Menandai mata kuliah sebagai favorites.
- Menampilkan status loading, kondisi data kosong, dan pesan error.
- Menyediakan antarmuka responsif untuk berbagai ukuran layar.
- Mengelola data melalui backend Supabase.

## 4. Cara Menjalankan Aplikasi

### Persyaratan

Pastikan perangkat telah memiliki:

- Flutter SDK.
- Dart SDK yang sesuai dengan Flutter.
- Visual Studio Code atau editor lain yang mendukung Flutter.
- Emulator atau perangkat untuk menjalankan aplikasi.
- Koneksi internet untuk mengakses backend Supabase.

### Langkah menjalankan

1. Clone repository proyek:

   ```bash
   git clone https://github.com/summerville-26/flutter-ui-fundamentals.git
   ```

2. Masuk ke direktori proyek:

   ```bash
   cd flutter-ui-fundamentals
   ```

3. Unduh dependensi:

   ```bash
   flutter pub get
   ```

4. Pastikan konfigurasi Supabase tersedia dan sesuai dengan proyek:

   ```text
   lib/config/supabase_config.dart
   ```

   Gunakan Supabase URL dan publishable/anon key yang sesuai. Jangan memasukkan `service_role` key atau secret server ke aplikasi Flutter.

5. Jalankan aplikasi:

   ```bash
   flutter run
   ```

## 5. Arsitektur Singkat

Aplikasi menggunakan pemisahan tanggung jawab agar pengelolaan data dan antarmuka lebih terstruktur.

- **Models** — mendefinisikan struktur data mata kuliah melalui model `Course`.
- **Services** — menangani komunikasi dengan backend Supabase melalui `CourseSupabaseService`.
- **Data Source** — mendefinisikan operasi akses data melalui `CourseDataSource`.
- **Repositories** — menyediakan perantara antara provider dan sumber data melalui `CourseRepository`.
- **Providers** — mengelola data mata kuliah, status loading, pesan error, dan operasi CRUD melalui `CourseProvider`.
- **State Management** — mengelola shared state favorites melalui `CourseState`.
- **Pages** — menyediakan halaman utama, daftar mata kuliah, detail, tambah, edit, dan profil.
- **Widgets** — menyediakan komponen antarmuka yang dapat digunakan kembali.

Alur pengelolaan data:

`Pages/Widgets → Provider → Repository → Service → Supabase`

Data hasil permintaan dikembalikan melalui lapisan yang sama untuk ditampilkan pada antarmuka.

## 6. Backend yang Digunakan

Backend aplikasi menggunakan Supabase dengan basis data PostgreSQL. Data mata kuliah disimpan dalam tabel `courses`.

Operasi yang didukung meliputi:

- **Create** — menambahkan mata kuliah.
- **Read** — mengambil dan menampilkan daftar mata kuliah.
- **Update** — memperbarui data mata kuliah.
- **Delete** — menghapus mata kuliah.

Akses database diatur melalui Row Level Security (RLS) dan policy Supabase. Pada konfigurasi praktikum saat ini, role `anon` diizinkan menjalankan operasi CRUD pada tabel `courses`. Konfigurasi ini digunakan untuk kebutuhan demonstrasi tanpa autentikasi dan tidak disarankan untuk aplikasi produksi karena akses data belum dibatasi berdasarkan identitas pengguna.

## 7. Pengujian dan Pemeriksaan

Pemeriksaan kode dapat dilakukan menggunakan perintah:

```bash
flutter analyze
```

Pengujian otomatis dapat dijalankan menggunakan:

```bash
flutter test
```

Hasil pemeriksaan perlu dievaluasi untuk memastikan tidak terdapat error yang belum dit

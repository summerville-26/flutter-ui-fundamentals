## Architecture dan Dependency Direction

Course Explorer v2 menggunakan pemisahan tanggung jawab untuk
mempermudah pemeliharaan dan pengembangan aplikasi.

### Struktur dan Tanggung Jawab Folder

- `models/`: Mendefinisikan struktur data, termasuk model Course,
  serta proses konversi data melalui fromJson dan toJson.
- `services/`: Menangani pengambilan data dari sumber data.
- `repositories/`: Menjadi perantara antara provider dan service.
- `providers/`: Mengelola state asinkron, data mata kuliah,
  loading, dan error.
- `pages/`: Menyediakan halaman aplikasi, seperti Home, Courses,
  Course Detail, dan Profile.
- `widgets/`: Menyimpan komponen antarmuka yang dapat digunakan
  kembali.
- `data/`: Menyimpan data mata kuliah simulasi yang digunakan
  sebagai sumber data.
- `course_state.dart`: Mengelola shared state favorit menggunakan
  ChangeNotifier.
- `main.dart`: Menjadi titik masuk aplikasi serta mengatur provider,
  tema, dan navigasi utama.

### Arah Dependency

Screen/Widget -> Provider -> Repository -> Service/Data Source

UI tidak mengakses sumber data secara langsung. Provider mengelola
state, repository mengatur akses data, dan service menangani
pengambilan data.

### Shared State

CourseState menyediakan status favorit yang digunakan bersama
oleh halaman daftar mata kuliah dan halaman detail. Perubahan
state diberitahukan melalui notifyListeners().

### Responsive Layout

Aplikasi mempertahankan navigasi responsif untuk menyesuaikan
tampilan dengan ukuran layar.

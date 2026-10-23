Tahap 1 — Membaca REST Endpoint dan JSON

1. Informasi REST API

Nama API: Course API - Pertemuan 7

Base URL: https://course-api-pearl.vercel.app

Endpoint: /courses

URL lengkap: https://course-api-pearl.vercel.app/courses

Metode HTTP: GET

Tujuan: Mengambil daftar mata kuliah dari REST API.

Format respons: JSON.

2. Struktur JSON

Field utama setiap objek Course:

id: identitas mata kuliah.

code: kode mata kuliah.

title: nama mata kuliah.

credits: jumlah kredit.

status: status mata kuliah.

create_at: waktu pembuatan

3. Hasil Pengujian

Status HTTP: 200 OK

Bentuk respons: [
{
"id": 1,
"code": "MOB01",
"title": "Git & GitHub",
"credits": 2,
"status": "active",
"created_at": "2026-10-21T03:28:08.91197Z"
},
{
"id": 2,
"code": "MOB02",
"title": "Dart Fundamentals",
"credits": 3,
"status": "active",
"created_at": "2026-10-21T03:28:09.128977Z"
},
{
"id": 3,
"code": "MOB03",
"title": "Flutter Widgets & Layout",
"credits": 3,
"status": "planned",
"created_at": "2026-10-21T03:28:09.361747Z"
},
{
"id": 4,
"code": "MOB04",
"title": "State Management Provider",
"credits": 2,
"status": "planned",
"created_at": "2026-10-21T03:28:09.576271Z"
},
{
"id": 5,
"code": "MOB05",
"title": "REST API & Database",
"credits": 3,
"status": "done",
"created_at": "2026-10-21T03:28:09.790592Z"
},
{
"id": 10,
"code": "juven01",
"title": "pembelajaran AI",
"credits": 3,
"status": "active",
"created_at": "2026-10-22T14:51:36.501933Z"
}
]

Jumlah data yang diterima: 6 mata kuliah

Kesimpulan: Endpoint GET /courses digunakan untuk mengambil data mata kuliah yang selanjutnya akan diproses dan ditampilkan oleh aplikasi Flutter.

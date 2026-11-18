# MyPortfolio Mobile

MyPortfolio Mobile merupakan aplikasi sederhana berbasis Flutter yang dibuat sebagai bagian dari Individual Assignment 7 mata kuliah Pemrograman Berbasis Platform (PBP). Aplikasi ini menampilkan informasi pribadi pemilik portofolio serta beberapa menu aksi yang dapat digunakan untuk mengakses dan mengelola portofolio.

## Features
- Menampilkan informasi NPM, nama, dan kelas.
- Menampilkan menu aksi Lihat Proyek, Tambah Proyek, Lihat Pengalaman, Tambah dan Logout.
- Menampilkan SnackBar sebagai feedback ketika tombol ditekan.
- Menggunakan warna berbeda untuk setiap tombol.
- Menggunakan color palette Old Copper, Butter Yellow, Nebula, dan Seashell.

## Tech Stack
- **Flutter** – Framework untuk membangun aplikasi mobile.
- **Dart** – Bahasa pemrograman yang digunakan.
- **Material Design** – Komponen UI untuk tampilan aplikasi.

## Getting Started
### Prerequisites
Pastikan perangkat sudah memiliki:
1. Flutter SDK
2. Dart SDK
3. Code editor, seperti Visual Studio Code
4. Browser Google Chrome atau emulator untuk menjalankan aplikasi

### Installation
1. Clone repository ini:
git clone <URL_REPOSITORY>

2. Masuk ke direktori proyek:
cd myportofolio_mobile

3. Install dependencies:
flutter pub get

4. Jalankan aplikasi:
flutter run -d chrome

### Analyze Project
Untuk memeriksa kemungkinan error atau masalah pada kode, jalankan:
flutter analyze

## Project Structure
```text
myportofolio_mobile/
├── android/
├── ios/
├── web/
├── lib/
│   ├── main.dart
│   └── menu.dart
├── test/
├── pubspec.yaml
├── pubspec.lock
├── analysis_options.yaml
└── README.md
```

## Development Progress
### Tutorial 8
- Membuat halaman utama menggunakan Flutter.
- Menampilkan informasi NPM, nama, dan kelas menggunakan InfoCard.
- Membuat menu menggunakan ItemHomepage dan ItemCard.
- Menambahkan ikon dan warna yang berbeda pada setiap menu.
- Menambahkan interaksi SnackBar saat menu ditekan.

### Tugas 7
- Menyesuaikan warna dan tampilan aplikasi dengan color palette.
- Menambahkan informasi profil mahasiswa.
- Menambahkan menu Lihat Proyek dan Tambah Proyek.
- Menambahkan menu Lihat Pengalaman dan Tambah Pengalaman.
- Menyesuaikan layout agar tidak mengalami overflow.
- Menambahkan interaksi SnackBar pada setiap ItemCard.
- Memperbarui dokumentasi dan AI disclosure.

## Refleksi Tugas
### Tugas 7
#### 1. Jelaskan bagaimana cara kerja `main.dart` dan bagaimana hubungan antara widget parent dan child dalam aplikasi Flutter yang kamu buat.

File `main.dart` merupakan file utama yang dijalankan ketika aplikasi Flutter dibuka. Di dalamnya terdapat fungsi `main()` yang menjalankan aplikasi melalui `runApp()`. Pada project ini, `MyApp` menjadi widget utama yang kemudian menampilkan halaman `MyHomePage`.

Dalam Flutter, tampilan aplikasi dibuat dari susunan widget yang saling berhubungan. Ada widget parent yang menampung widget lain sebagai child-nya. Contohnya, `MyApp` menampung `MaterialApp`, lalu `MaterialApp` menampilkan `MyHomePage`. Di dalam `MyHomePage` juga terdapat widget lain seperti `Scaffold`, `AppBar`, `InfoCard`, dan `ItemCard` yang digunakan untuk membentuk tampilan halaman.

#### 2. Sebutkan seluruh widget yang kamu gunakan dalam tugas ini dan jelaskan fungsinya.

Beberapa widget yang saya gunakan dalam project ini antara lain:

- `MaterialApp` untuk mengatur aplikasi secara keseluruhan.
- `Scaffold` untuk membuat struktur dasar halaman.
- `AppBar` untuk menampilkan bagian atas halaman.
- `Text` untuk menampilkan tulisan seperti NPM, nama, kelas, dan nama menu.
- `Container` untuk mengatur tampilan suatu elemen, seperti warna dan ukurannya.
- `Column` untuk menyusun widget secara vertikal.
- `Row` untuk menyusun widget secara horizontal.
- `GridView.count` untuk menyusun menu dalam bentuk grid.
- `Icon` untuk menampilkan ikon pada setiap menu.
- `Material` untuk mengatur tampilan elemen menggunakan Material Design.
- `InkWell` untuk membuat elemen bisa ditekan oleh pengguna.
- `SnackBar` untuk menampilkan pesan setelah pengguna menekan salah satu menu.
- `SingleChildScrollView` supaya halaman bisa digulir jika kontennya melebihi tinggi layar.
- `Padding` untuk memberikan jarak pada suatu widget.
- `SizedBox` untuk memberikan jarak atau mengatur ukuran elemen.

Selain itu, saya juga menggunakan custom widget seperti `InfoCard` dan `ItemCard` untuk membuat bagian tampilan yang bisa digunakan kembali tanpa harus menuliskan susunan widget yang sama berulang kali.

#### 3. Apa fungsi dari `MaterialApp` dan mengapa widget ini sering digunakan sebagai root widget?

`MaterialApp` digunakan untuk mengatur hal-hal dasar dalam aplikasi Flutter, seperti tema, navigasi, dan halaman yang pertama kali ditampilkan. Widget ini biasanya diletakkan di bagian paling atas karena menjadi tempat pengaturan utama bagi widget-widget lainnya. Jadi, widget lain yang ada di dalam aplikasi bisa mengikuti konfigurasi yang sudah diatur melalui `MaterialApp`.

#### 4. Apa perbedaan antara `StatelessWidget` dan `StatefulWidget`? Kapan sebaiknya menggunakan masing-masing widget?

Dari yang saya pahami, `StatelessWidget` digunakan untuk widget yang tampilannya tidak perlu berubah berdasarkan state internal. Contohnya seperti bagian informasi profil yang hanya menampilkan NPM, nama, dan kelas. Sementara itu, `StatefulWidget` digunakan ketika tampilan suatu widget perlu berubah mengikuti kondisi tertentu. Misalnya, ketika pengguna menekan tombol counter dan angka yang ditampilkan ikut berubah.

Pada project ini, saya menggunakan `StatelessWidget` untuk `MyHomePage`, `InfoCard`, dan `ItemCard` karena tampilan yang dibuat tidak membutuhkan perubahan state internal. Untuk interaksi tombol, saya hanya menggunakan `SnackBar` untuk menampilkan pesan ketika tombol ditekan.

#### 5. Apa yang dimaksud dengan `BuildContext` dan bagaimana penggunaannya dalam metode `build()`?

`BuildContext` merupakan sesuatu yang digunakan Flutter untuk mengetahui posisi suatu widget di dalam susunan widget yang ada. Dari yang saya pahami, `context` juga bisa digunakan untuk mengakses widget atau fitur lain yang berada di atasnya.

Pada project ini, saya menggunakan `context` ketika ingin menampilkan `SnackBar` melalui `ScaffoldMessenger.of(context)`. Jadi, ketika pengguna menekan salah satu menu, aplikasi menggunakan context tersebut untuk menemukan tempat yang sesuai untuk menampilkan pesan.

#### 6. Apa perbedaan antara hot reload dan hot restart dalam Flutter? Kapan sebaiknya menggunakan hot restart?

Hot reload digunakan untuk melihat perubahan kode tanpa harus menjalankan ulang aplikasi dari awal. Misalnya, ketika saya mengubah warna atau mengatur ulang ukuran widget, saya bisa menggunakan hot reload untuk langsung melihat hasil perubahannya. State aplikasi yang sedang berjalan umumnya tetap dipertahankan. Sedangkan hot restart akan menjalankan ulang aplikasi dari awal sehingga kondisi atau state sebelumnya akan di-reset. Hot restart bisa digunakan ketika perubahan yang dilakukan tidak cukup diterapkan dengan hot reload atau ketika ingin melihat aplikasi kembali dari kondisi awal.

Selama mengerjakan tugas ini, saya lebih sering menggunakan hot reload karena cukup membantu ketika sedang mencoba beberapa perubahan pada tampilan aplikasi.

#### AI Disclosure
Saya menggunakan ChatGPT saat mengalami kesulitan dalam memahami konsep Flutter atau mencari tahu penyebab error yang saya temui. ChatGPT juga saya gunakan untuk melihat beberapa alternatif cara penyelesaian, terutama dalam mengatur tampilan widget, mengatasi layout overflow, dan memahami penggunaan beberapa widget. Setelah itu, saya menyesuaikan dan menerapkan solusi tersebut pada project sesuai dengan kebutuhan saya.
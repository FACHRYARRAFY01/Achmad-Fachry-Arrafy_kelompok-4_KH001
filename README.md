# Praktikum 5 - Pemrograman Mobile

## Identitas Mahasiswa
- **Nama:** Fachry Alfarizky
- **NIM:** 20240801063
- **Kelompok / Kelas:** Kelompok 9 / KH001

## Deskripsi
Praktikum ini mengembangkan aplikasi Flutter dari praktikum sebelumnya dengan mengubah input data statis menjadi form input dinamis yang terhubung dengan Firebase Cloud Firestore. Pengguna dapat memasukkan data melalui antarmuka aplikasi, melakukan validasi input, dan menyimpannya langsung ke dalam database Firestore.

## Implementasi
- **Input Form Dinamis:** Menggunakan widget TextFormField untuk menerima input Nama, NIM, Lokasi, dan Mata Kuliah.
- **Dropdown Keterangan Kehadiran:** Menggunakan DropdownButtonFormField dengan pilihan status kehadiran (Hadir, Izin, Sakit).
- **Validasi Input:** Menerapkan validasi pada seluruh field wajib agar data kosong tidak dapat dikirim ke database.
- **Integrasi Cloud Firestore:** Menyimpan seluruh data form pengguna ke dalam collection praktikum melalui fungsi simpanData().
- **Notifikasi & Reset Form:** Menampilkan SnackBar notifikasi ketika penyimpanan berhasil maupun gagal, serta mengosongkan kembali seluruh field input setelah proses penyimpanan sukses.

## Hasil
Aplikasi berhasil menampilkan form input data mahasiswa beserta validasinya, mengirimkan data ke Firebase Cloud Firestore (collection praktikum), memberikan umpan balik notifikasi secara langsung, dan mereset form setelah data tersimpan.

## Teknologi
- Flutter
- Dart
- Firebase Core
- Cloud Firestore

## Struktur File
```text
lib/
├── firebase_options.dart
└── main.dart
```

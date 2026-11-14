Nama: Aulia Nur Shiva

NPM: 2506619316

Kelas: PBP A

## MyPortfolio Mobile

Aplikasi mobile Flutter sebagai klien portofolio pribadi, pendamping website Django `myportofolio`. Halaman utama menampilkan identitas pemilik (`InfoCard`) dan menu aksi berwarna (`ItemCard`) yang memunculkan `SnackBar` ketika ditekan.

### Cara menjalankan

```bash
flutter pub get
flutter run -d chrome
flutter analyze
```

### Tugas 7

1. Widget tree adalah struktur hierarki dari seluruh widget yang menyusun tampilan aplikasi Flutter. Pada proyek ini, `runApp` menjalankan `MyApp`, lalu `MaterialApp` membungkus `MyHomePage`, yang mengembalikan `Scaffold`, kemudian `AppBar` dan `body` sebagai anak-anaknya, dan seterusnya sampai ke `Text` dan `Icon` di dalam kartu. Hubungan parent-child bekerja dengan parent membungkus child melalui properti seperti `child` atau `children`. Parent memberi batasan ukuran (constraints) ke child, child menentukan ukurannya sendiri dalam batasan itu, lalu parent yang menentukan posisinya. Contohnya, `Column` (parent) menyusun `Row` dan `GridView` (child) secara vertikal. Satu widget hanya punya satu parent, dan perubahan pada suatu widget hanya membangun ulang bagian pohon di bawahnya.

2. Widget yang saya gunakan:
   - `MaterialApp`: root aplikasi yang menyediakan tema, judul, dan halaman awal.
   - `Scaffold`: kerangka dasar halaman (AppBar, body, tempat SnackBar muncul).
   - `AppBar`: bar judul di bagian atas halaman.
   - `SingleChildScrollView`: membuat isi halaman bisa di-scroll agar tidak overflow di layar lebar.
   - `Padding`: memberi jarak di sekeliling isi.
   - `Column` dan `Row`: menyusun widget secara vertikal dan horizontal.
   - `Center`: menempatkan child di tengah.
   - `SizedBox`: memberi jarak kosong dengan ukuran tertentu.
   - `GridView.count`: menampilkan `ItemCard` dalam kisi 3 kolom.
   - `Card` dan `Container`: kartu dengan bayangan dan wadah dengan padding dan lebar untuk `InfoCard`.
   - `Material` dan `InkWell`: latar kartu berwarna dengan sudut membulat dan efek sentuh pada `ItemCard`.
   - `Icon` dan `Text`: menampilkan ikon dan teks.
   - `SnackBar` dan `ScaffoldMessenger`: menampilkan dan mengelola notifikasi di bawah layar saat tombol ditekan.
   - `InfoCard` dan `ItemCard`: widget buatan sendiri yang bisa dipakai ulang.

3. `MaterialApp` adalah widget yang menyiapkan fondasi aplikasi bergaya Material Design, seperti tema (`theme`), judul (`title`), halaman awal (`home`), navigasi antar halaman, dan pengaturan lokalisasi. Widget ini juga menyediakan hal-hal yang dibutuhkan widget lain, misalnya `Theme.of(context)` untuk membaca warna tema dan `ScaffoldMessenger` untuk menampilkan `SnackBar`. Karena itu `MaterialApp` umumnya dipasang sebagai root: semua widget di bawahnya otomatis mendapat tema dan layanan tersebut tanpa perlu dikonfigurasi satu per satu.

4. `StatelessWidget` adalah widget yang tampilannya tidak berubah selama hidupnya karena tidak menyimpan state, sedangkan `StatefulWidget` punya objek `State` yang menyimpan data yang bisa berubah, dan tampilannya dibangun ulang lewat `setState`. Pilih `StatelessWidget` untuk tampilan statis, seperti `MyHomePage`, `InfoCard`, dan `ItemCard` di proyek ini yang datanya tetap. Pilih `StatefulWidget` jika tampilan harus berubah mengikuti data, misalnya penghitung angka, isian form, atau data hasil request ke API yang diperbarui.

5. `BuildContext` adalah penanda lokasi sebuah widget di dalam widget tree. Lewat `context`, sebuah widget bisa mengakses informasi dari widget-widget di atasnya (ancestor). Di dalam method `build`, `context` dipakai untuk memanggil `Theme.of(context)` agar mengambil warna tema, `MediaQuery.of(context)` agar mengetahui ukuran layar (dipakai di `InfoCard`), dan `ScaffoldMessenger.of(context)` agar menampilkan `SnackBar` (dipakai di `ItemCard`). Tanpa `context`, widget tidak tahu posisinya di pohon sehingga tidak bisa mengakses data dari ancestor tersebut.

6. Hot reload menyuntikkan kode yang baru diubah ke aplikasi yang sedang berjalan lalu membangun ulang widget tree, tanpa kehilangan state aplikasi. Hot restart memulai ulang aplikasi dari awal, sehingga state kembali ke nilai awal, tetapi tetap lebih cepat daripada menjalankan ulang penuh. Hot reload tidak cukup ketika mengubah hal yang hanya dievaluasi saat aplikasi dimulai, misalnya isi `main()`, variabel global atau `static`, dan inisialisasi state awal, sehingga perlu hot restart. Perubahan pada `pubspec.yaml` (menambah dependensi atau aset) dan kode native Android/iOS (misalnya konfigurasi di folder `android/`) membutuhkan full restart, yaitu menghentikan lalu menjalankan ulang `flutter run`.

### AI Disclosure Tugas 7

Saya menggunakan ChatGPT sebagai asisten selama mengerjakan Tugas 7.

- **Bagian yang dibantu AI:** memahami instruksi tugas, menyelesaikan masalah instalasi Flutter di Windows (error path terlalu panjang saat ekstrak dan pengaturan PATH), dan membantu masalah *BOTTOM OVERFLOWED*.
- **Strategi prompting:** memberi konteks secara umum tugas apa yang sedang saya kerjakan, menempelkan masalah yang sedang dihadapi dan bertanya mengapa hal tersebut bisa terjadi, dan memastikan apakah kode yang saya tulis sudah betul apa belum.
- **Keterbatasan AI dan perbaikan manual:** Tampilan mengalami *BOTTOM OVERFLOWED* saat browser fullscreen karena grid kartu membesar mengikuti lebar layar. Masalah ini saya temukan sendiri saat menjalankan aplikasi di Chrome, lalu diperbaiki dengan `SingleChildScrollView` dan `childAspectRatio`. Saya juga memverifikasi hasil akhirnya sendiri dengan `flutter analyze` dan mencoba setiap tombol di Chrome.
- **Tautan chat:** https://chatgpt.com/share/6af80972-fd18-83ec-9f46-9a0fa853cdb3 
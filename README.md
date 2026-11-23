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

### Tugas 8

1. `Navigator.push()` membuka halaman baru di atas halaman yang sedang ditampilkan, sehingga halaman sebelumnya tetap tersimpan di navigation stack dan pengguna bisa kembali ke sana. `Navigator.pushReplacement()` membuka halaman baru sekaligus menggantikan halaman yang sedang ditampilkan, sehingga halaman yang digantikan tidak bisa dikembalikan dengan tombol back. `Navigator.pop()` menghapus halaman paling atas dari stack dan membawa pengguna kembali ke halaman di bawahnya. Untuk membuka formulir dari kartu aksi, saya memakai `Navigator.push()` karena pengguna harus bisa kembali ke halaman utama dengan tombol back bawaan perangkat atau browser. Opsi Home di drawer memanggil `Navigator.pushReplacement()` ke `MyHomePage`, sehingga halaman formulir yang sedang tampil digantikan oleh halaman utama. Satu hal yang saya amati: jika formulir dibuka lewat kartu (`push`) lalu pengguna menekan Home di drawer, stack menjadi `[Home, Home]` sehingga tombol back masih bisa kembali ke halaman utama yang lama. Fungsinya tetap berjalan sesuai tujuan.

2. `Scaffold` adalah kerangka dasar halaman yang menyediakan slot untuk `AppBar`, `Drawer`, dan `body`. Dengan memakai susunan yang sama di setiap halaman, header, menu navigasi, dan area konten selalu berada di posisi yang sama, sehingga pengguna tidak perlu beradaptasi ulang saat berpindah halaman. Drawer juga dibuat sekali sebagai widget `LeftDrawer` lalu dipakai di halaman utama dan semua halaman formulir. Contoh penggunaan warna tema: seed color `0xFF31582B` didefinisikan sekali lewat `ColorScheme.fromSeed` di `main.dart`, lalu dipakai melalui `Theme.of(context).colorScheme.primary` pada `AppBar` halaman utama, `AppBar` halaman formulir, `DrawerHeader`, dan tombol Save, sehingga identitas visual portofolio tetap sama di seluruh halaman.

3. Formulir disusun dengan `Column` di dalam `SingleChildScrollView` agar semua input tersusun vertikal, satu kolom per field, yang mudah dibaca dan diisi di layar ponsel. `Padding` (`EdgeInsets.all(8.0)`) dipakai untuk memberi jarak antar input supaya tampilan tidak terlalu rapat dan area sentuh tidak saling berdempetan. Ketika ruang layar terbatas, misalnya di layar sempit atau saat papan ketik tampil dan mengurangi tinggi area yang tersedia, `SingleChildScrollView` membuat isi formulir bisa digulir sehingga input paling bawah dan tombol Save tetap bisa dijangkau tanpa terjadi overflow.

4. `GlobalKey<FormState>` dipasang pada widget `Form` agar kode di luar field, yaitu tombol Save, bisa mengakses `FormState` milik form tersebut. `validator` pada setiap `TextFormField` adalah fungsi yang memeriksa nilai field dan mengembalikan pesan error jika nilainya tidak sesuai aturan, atau `null` jika valid. Saat tombol Save ditekan, `_formKey.currentState!.validate()` menjalankan semua validator sekaligus. Jika ada yang gagal, pesan error ditampilkan di kolom terkait dan hasilnya `false`; dialog ringkasan hanya ditampilkan jika hasilnya `true`. Contohnya pada Thumbnail URL: `keyboardType: TextInputType.url` hanya mengubah tampilan papan ketik dan tidak membatasi isi, sehingga pengguna tetap bisa mengetik `abc` atau menempel teks apa saja. Karena itu validator memeriksa bahwa nilai diawali `http://` atau `https://`, dan `abc` ditolak. Contoh lain, Title yang hanya berisi spasi ditolak lewat `trim().isEmpty`, dan End Date yang lebih awal dari Start Date tidak bisa dicegah oleh date picker saja, sehingga perlu dicek di validator.

**Catatan tentang drawer:** karena portofolio saya tidak memiliki bagian Project, opsi Add Project pada Tutorial 09 saya ganti dengan Add Interest, dan saya tambahkan Add Experience sebagai formulir baru untuk Tugas 8. Opsi Home tetap dipertahankan.

### AI Disclosure Tugas 8

Saya menggunakan ChatGPT sebagai asisten selama mengerjakan Tugas 8.

- **Bagian yang dibantu AI:** Membantu memahami konsep navigasi Flutter menggunakan `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`, serta menjelaskan cara kerja validasi form menggunakan `validator`, `FormState`, dan `GlobalKey<FormState>()`
- **Strategi prompting:** Saya memberikan pertanyaan berdasarkan fitur yang sedang saya implementasikan, seperti navigasi antarhalaman dan validasi input pada Experience Form, agar penjelasan AI relevan dengan kode yang saya buat
- **Keterbatasan AI dan perbaikan manual:** Penjelasan AI digunakan sebagai referensi untuk memahami konsep dan implementasi. Saya tetap menyesuaikan kode dengan struktur project yang sudah ada, melakukan implementasi secara mandiri, serta menguji fitur untuk memastikan kode berjalan sesuai kebutuhan
- **Tautan chat:** https://chatgpt.com/share/6b03dbc1-4260-83ec-85a6-87677b3e53c2 
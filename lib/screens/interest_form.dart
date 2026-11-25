import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/interest.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class InterestFormPage extends StatefulWidget {
  const InterestFormPage({super.key});

  @override
  State<InterestFormPage> createState() => _InterestFormPageState();
}

class _InterestFormPageState extends State<InterestFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _category = "exploring"; // default
  String _description = "";
  bool _isSubmitting = false;

  // value = nilai di model Django, label = teks yang ditampilkan
  final Map<String, String> _categories = {
    'exploring': 'Currently Exploring',
    'fun': 'For Fun',
  };

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthState>();
    final api = context.read<ApiClient>();
    final messenger = ScaffoldMessenger.of(context);

    // Pastikan sudah login (kalau belum, buka layar login).
    final loggedIn = await ensureLoggedIn(context);
    if (!loggedIn || !mounted) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final created = await api.createInterest(
        Interest(
          name: _name.trim(),
          category: _category,
          description: _description.trim(),
        ),
        token: auth.token!,
      );

      if (!mounted) return;
      _showSuccessDialog(created);
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        // Token tidak valid/kadaluarsa: logout lalu minta login ulang.
        await auth.logout();
        messenger.showSnackBar(
          const SnackBar(content: Text('Sesi berakhir. Silakan login ulang.')),
        );
        if (!mounted) return;
        await ensureLoggedIn(context);
      } else if (e.statusCode == 403) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text(
              'Akun ini tidak punya izin menambah interest '
              '(hanya pemilik portofolio).',
            ),
          ),
        );
      } else {
        messenger.showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan interest (${e.statusCode}).'),
          ),
        );
      }
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Tidak bisa terhubung ke server.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showSuccessDialog(Interest created) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Interest berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama: ${created.name}'),
                Text('Kategori: ${created.categoryLabel}'),
                Text(
                  'Deskripsi: ${created.description.isEmpty ? "-" : created.description}',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                _formKey.currentState!.reset();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Interest Form')),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Interest Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 100,
                  decoration: InputDecoration(
                    hintText: "Web Dev",
                    labelText: "Interest Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama interest tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _category,
                  items: _categories.entries
                      .map(
                        (entry) => DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Tell us about this interest",
                    labelText: "Description (optional, only for Fun category)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(primary),
                    ),
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

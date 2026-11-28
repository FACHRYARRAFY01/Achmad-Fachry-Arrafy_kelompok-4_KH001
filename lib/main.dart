import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Praktikum 5 - Form Input Firebase',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const FormKehadiranPage(),
    );
  }
}

class FormKehadiranPage extends StatefulWidget {
  const FormKehadiranPage({super.key});

  @override
  State<FormKehadiranPage> createState() => _FormKehadiranPageState();
}

class _FormKehadiranPageState extends State<FormKehadiranPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _mataKuliahController = TextEditingController();

  String? _keteranganKehadiran;
  final List<String> _opsiKehadiran = ['Hadir', 'Izin', 'Sakit'];

  bool _isLoading = false;

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _lokasiController.dispose();
    _mataKuliahController.dispose();
    super.dispose();
  }

  Future<void> simpanData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('praktikum').add({
        'nama': _namaController.text.trim(),
        'nim': _nimController.text.trim(),
        'lokasi': _lokasiController.text.trim(),
        'mata_kuliah': _mataKuliahController.text.trim(),
        'keterangan_kehadiran': _keteranganKehadiran,
        'waktu_simpan': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil disimpan ke Cloud Firestore!'),
          backgroundColor: Colors.green,
        ),
      );

      // Kosongkan kembali seluruh field input setelah berhasil
      _formKey.currentState!.reset();
      _namaController.clear();
      _nimController.clear();
      _lokasiController.clear();
      _mataKuliahController.clear();
      setState(() {
        _keteranganKehadiran = null;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Kehadiran Praktikum'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nimController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  prefixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'NIM wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lokasiController,
                decoration: const InputDecoration(
                  labelText: 'Lokasi',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Lokasi wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _mataKuliahController,
                decoration: const InputDecoration(
                  labelText: 'Mata Kuliah',
                  prefixIcon: Icon(Icons.book),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Mata Kuliah wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _keteranganKehadiran,
                decoration: const InputDecoration(
                  labelText: 'Keterangan Kehadiran',
                  prefixIcon: Icon(Icons.check_circle_outline),
                  border: OutlineInputBorder(),
                ),
                items: _opsiKehadiran.map((String opsi) {
                  return DropdownMenuItem<String>(
                    value: opsi,
                    child: Text(opsi),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _keteranganKehadiran = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Silakan pilih keterangan kehadiran';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : simpanData,
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),
                label: Text(_isLoading ? 'Menyimpan...' : 'Simpan'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

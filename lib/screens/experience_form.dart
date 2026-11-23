import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _startDateController =
      TextEditingController();
  final TextEditingController _endDateController =
      TextEditingController();

  String _title = "";
  String _description = "";
  String _category = "internship";
  String _thumbnail = "";

  DateTime? _startedAt;
  DateTime? _endedAt;
  bool _isOngoing = false;

  final List<Map<String, String>> _categories = [
    {'value': 'internship', 'label': 'Internship'},
    {'value': 'research', 'label': 'Research'},
    {'value': 'volunteer', 'label': 'Volunteer'},
    {'value': 'part-time', 'label': 'Part-Time'},
    {'value': 'full-time', 'label': 'Full-Time'},
    {'value': 'freelance', 'label': 'Freelance'},
    {'value': 'organization', 'label': 'Organization'},
    {'value': 'committee', 'label': 'Committee'},
  ];

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Future<void> _selectStartDate() async {
    final today = _dateOnly(DateTime.now());

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _startedAt ?? today,
      firstDate: DateTime(1900),
      lastDate: today,
      helpText: 'Pilih Tanggal Mulai',
    );

    if (selectedDate == null) return;

    setState(() {
      _startedAt = _dateOnly(selectedDate);
      _startDateController.text = _formatDate(_startedAt!);

      // Hapus tanggal selesai jika tidak lagi setelah tanggal mulai.
      if (_endedAt != null &&
          !_endedAt!.isAfter(_startedAt!)) {
        _endedAt = null;
        _endDateController.clear();
      }
    });
  }

  Future<void> _selectEndDate() async {
    if (_startedAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih tanggal mulai terlebih dahulu.'),
        ),
      );
      return;
    }

    final today = _dateOnly(DateTime.now());
    final firstAvailableDate =
        _startedAt!.add(const Duration(days: 1));

    if (firstAvailableDate.isAfter(today)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Tanggal selesai harus setelah tanggal mulai dan tidak boleh di masa depan.',
          ),
        ),
      );
      return;
    }

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _endedAt ?? firstAvailableDate,
      firstDate: firstAvailableDate,
      lastDate: today,
      helpText: 'Pilih Tanggal Selesai',
    );

    if (selectedDate == null) return;

    setState(() {
      _endedAt = _dateOnly(selectedDate);
      _endDateController.text = _formatDate(_endedAt!);
    });
  }

  String? _validateThumbnail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final uri = Uri.tryParse(value.trim());

    if (uri == null ||
        !uri.hasScheme ||
        !['http', 'https'].contains(uri.scheme) ||
        uri.host.isEmpty) {
      return 'Masukkan URL yang valid (http/https).';
    }

    return null;
  }

  void _saveExperience() {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      builder: (dialogContext) {
        final categoryLabel = _categories.firstWhere(
          (category) => category['value'] == _category,
        )['label'];

        return AlertDialog(
          title: const Text('Pengalaman berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Nama Pengalaman: $_title'),
                const SizedBox(height: 8),
                Text('Deskripsi: $_description'),
                const SizedBox(height: 8),
                Text('Kategori: $categoryLabel'),
                const SizedBox(height: 8),
                Text(
                  'Thumbnail: ${_thumbnail.trim().isEmpty ? "-" : _thumbnail}',
                ),
                const SizedBox(height: 8),
                Text('Tanggal Mulai: ${_formatDate(_startedAt!)}'),
                const SizedBox(height: 8),
                Text(
                  'Tanggal Selesai: ${_isOngoing ? "Masih berlangsung" : _formatDate(_endedAt!)}',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pengalaman'),
        backgroundColor: AppColors.oldCopper,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama Pengalaman
              TextFormField(
                maxLength: 255,
                decoration: const InputDecoration(
                  labelText: 'Nama Pengalaman',
                  hintText: 'Contoh: Staff Product Management RISTEK',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama pengalaman tidak boleh kosong.';
                  }
                  return null;
                },
                onChanged: (value) {
                  _title = value;
                },
              ),
              const SizedBox(height: 12),

              // Deskripsi
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  hintText: 'Ceritakan pengalaman kamu...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Deskripsi tidak boleh kosong.';
                  }
                  return null;
                },
                onChanged: (value) {
                  _description = value;
                },
              ),
              const SizedBox(height: 20),

              // Kategori
              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: const InputDecoration(
                  labelText: 'Kategori Pengalaman',
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category['value'],
                    child: Text(category['label']!),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _category = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              // Thumbnail
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'URL Thumbnail (Opsional)',
                  hintText: 'https://example.com/image.jpg',
                  border: OutlineInputBorder(),
                ),
                validator: _validateThumbnail,
                onChanged: (value) {
                  _thumbnail = value;
                },
              ),
              const SizedBox(height: 20),

              // Tanggal Mulai
              TextFormField(
                controller: _startDateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Mulai',
                  hintText: 'Pilih tanggal mulai',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: _selectStartDate,
                validator: (value) {
                  if (_startedAt == null) {
                    return 'Tanggal mulai wajib dipilih.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Status pengalaman
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Masih berlangsung'),
                value: _isOngoing,
                activeColor: AppColors.oldCopper,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _isOngoing = value ?? false;

                    if (_isOngoing) {
                      _endedAt = null;
                      _endDateController.clear();
                    }
                  });
                },
              ),

              // Tanggal Selesai
              TextFormField(
                controller: _endDateController,
                readOnly: true,
                enabled: !_isOngoing,
                decoration: InputDecoration(
                  labelText: 'Tanggal Selesai',
                  hintText: _isOngoing
                      ? 'Tidak perlu diisi'
                      : 'Pilih tanggal selesai',
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                onTap: _isOngoing ? null : _selectEndDate,
                validator: (value) {
                  if (_isOngoing) return null;

                  if (_endedAt == null) {
                    return 'Tanggal selesai wajib dipilih.';
                  }

                  if (_startedAt != null &&
                      !_endedAt!.isAfter(_startedAt!)) {
                    return 'Tanggal selesai harus setelah tanggal mulai.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Tombol Simpan
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.oldCopper,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _saveExperience,
                  child: const Text('Simpan Pengalaman'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
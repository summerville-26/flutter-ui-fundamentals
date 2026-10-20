import 'package:flutter/material.dart';

import '../main.dart';

// I Komang Candra Aryadinata || 2415051085
class FeedbackFormWidget extends StatefulWidget {
  const FeedbackFormWidget({super.key});

  @override
  State<FeedbackFormWidget> createState() => _FeedbackFormWidgetState();
}

class _FeedbackFormWidgetState extends State<FeedbackFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi Feedback'),
        content: Text(
          'Kirim feedback dari $studentName ($studentId)?\n\n'
          'Isi: "${_commentController.text}"',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _commentController.clear();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Feedback berhasil dikirim! Terima kasih.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _commentController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Komentar / Feedback',
              border: OutlineInputBorder(),
              hintText: 'Tuliskan masukan Anda (minimal 5 karakter)...',
            ),
            validator: (value) {
              if (value == null || value.trim().length < 5) {
                return 'Komentar harus berisi minimal 5 karakter!';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: _submitForm,
              child: const Text('Kirim Feedback'),
            ),
          ),
        ],
      ),
    );
  }
}

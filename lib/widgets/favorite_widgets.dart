import 'package:flutter/material.dart';

// I Komang Candra Aryadinata || 2415051085
class FavoriteToggleChild extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onToggle;

  const FavoriteToggleChild({
    super.key,
    required this.isFavorite,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Child 1: Kontrol Favorit',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            Text(isFavorite ? 'Status: Favorit' : 'Status: Bukan favorit'),
            TextButton(onPressed: onToggle, child: const Text('Ubah status')),
          ],
        ),
      ),
    );
  }
}

class FavoriteStatusChild extends StatelessWidget {
  final bool isFavorite;

  const FavoriteStatusChild({super.key, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Child 2: Tampilan Status',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            const Text(
              'Status mengikuti nilai dari parent.',
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

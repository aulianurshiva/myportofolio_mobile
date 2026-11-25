import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/interest.dart';

class InterestDetailScreen extends StatelessWidget {
  const InterestDetailScreen({required this.interest, super.key});

  final Interest interest;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(interest.name),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              interest.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Chip(label: Text(interest.categoryLabel)),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(interest.description.isEmpty ? '-' : interest.description),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text('${interest.starCount} stars'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

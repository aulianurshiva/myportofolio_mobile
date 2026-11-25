import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/interest.dart';
import 'package:myportofolio_mobile/screens/interest_detail_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class InterestListScreen extends StatefulWidget {
  const InterestListScreen({super.key});

  @override
  State<InterestListScreen> createState() => _InterestListScreenState();
}

class _InterestListScreenState extends State<InterestListScreen> {
  late Future<List<Interest>> _interestsFuture;

  @override
  void initState() {
    super.initState();
    // Future dibuat di initState (bukan di build) supaya request HTTP
    // tidak dikirim ulang setiap widget dibangun ulang.
    _interestsFuture = context.read<ApiClient>().getInterests();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getInterests();
    setState(() {
      _interestsFuture = future;
    });
    await future;
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interests'),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Interest>>(
        future: _interestsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Failed to load interests: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final interests = snapshot.data ?? const <Interest>[];

          // List kosong tetap dibungkus RefreshIndicator + scroll view
          // supaya pull-to-refresh masih bisa dipakai.
          if (interests.isEmpty) {
            return RefreshIndicator(
              onRefresh: _reload,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: const SizedBox(
                  height: 300,
                  child: Center(child: Text('No interests found.')),
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: interests.length,
              itemBuilder: (context, index) {
                final interest = interests[index];

                return Card(
                  child: ListTile(
                    title: Text(interest.name),
                    subtitle: Text(
                      interest.description.isEmpty
                          ? interest.categoryLabel
                          : '${interest.categoryLabel} • ${interest.description}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text('★ ${interest.starCount}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              InterestDetailScreen(interest: interest),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

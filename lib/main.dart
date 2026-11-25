import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp(apiClient: ApiClient()));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.apiClient, super.key});

  final ApiClient apiClient;

  @override
  Widget build(BuildContext context) {
    // MultiProvider menyisipkan objek yang sering dipakai (API client,
    // state autentikasi) ke widget tree supaya bisa diakses dari mana saja.
    return MultiProvider(
      providers: [Provider.value(value: apiClient)],
      child: MaterialApp(
        title: 'MyPortfolio',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF31582B)),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

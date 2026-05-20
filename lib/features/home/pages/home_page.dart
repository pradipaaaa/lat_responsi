import 'package:flutter/material.dart';
import 'package:news_app/features/auth/data/auth_repository.dart';
import 'package:news_app/features/auth/pages/login_page.dart';
import 'package:news_app/features/home/widgets/menu_tile.dart';
import 'package:news_app/features/spaceflight/models/content_category.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.username, super.key});

  final String username;

  Future<void> _logout(BuildContext context) async {
    await AuthRepository.logout();

    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halo, $username'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Text(
              'Pilih Menu',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              'Data diambil langsung dari Spaceflight News API.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 18),
            for (final category in contentCategories) ...[
              MenuTile(category: category),
              const SizedBox(height: 14),
            ],
          ],
        ),
      ),
    );
  }
}

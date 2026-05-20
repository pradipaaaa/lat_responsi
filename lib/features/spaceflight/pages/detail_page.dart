import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/app_states.dart';
import 'package:news_app/core/widgets/remote_image.dart';
import 'package:news_app/features/spaceflight/data/spaceflight_api.dart';
import 'package:news_app/features/spaceflight/models/content_category.dart';
import 'package:news_app/features/spaceflight/models/spaceflight_item.dart';
import 'package:news_app/features/spaceflight/widgets/metadata_row.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({required this.category, required this.item, super.key});

  final ContentCategory category;
  final SpaceflightItem item;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<SpaceflightItem> _futureItem;
  SpaceflightItem? _loadedItem;

  @override
  void initState() {
    super.initState();
    _futureItem = _loadDetail();
  }

  Future<SpaceflightItem> _loadDetail() async {
    final item = await SpaceflightApi.fetchDetail(
      widget.category,
      widget.item.id,
    );
    _loadedItem = item;
    return item;
  }

  Future<void> _openSource() async {
    final url = _loadedItem?.url ?? widget.item.url;
    final uri = Uri.tryParse(url);

    if (uri == null) {
      _showMessage('URL tidak valid.');
      return;
    }

    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!mounted) return;

    if (!opened) {
      _showMessage('Gagal membuka halaman web.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final sourceUrl = _loadedItem?.url ?? widget.item.url;

    return Scaffold(
      appBar: AppBar(title: Text('Detail ${widget.category.singularTitle}')),
      floatingActionButton: sourceUrl.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: _openSource,
              icon: const Icon(Icons.open_in_new),
              label: const Text('Buka Web'),
            ),
      body: FutureBuilder<SpaceflightItem>(
        future: _futureItem,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingState(message: 'Memuat detail...');
          }

          if (snapshot.hasError) {
            return ErrorState(
              message: snapshot.error.toString(),
              onRetry: () {
                setState(() {
                  _futureItem = _loadDetail();
                });
              },
            );
          }

          final item = snapshot.data ?? widget.item;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: RemoteImage(
                    imageUrl: item.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                item.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 12),
              MetadataRow(item: item),
              if (item.authorNames.isNotEmpty) ...[
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final author in item.authorNames)
                      Chip(
                        avatar: const Icon(Icons.edit_outlined, size: 16),
                        label: Text(author),
                      ),
                  ],
                ),
              ],
              const SizedBox(height: 18),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    item.summary.isEmpty
                        ? 'Tidak ada ringkasan.'
                        : item.summary,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(height: 1.5),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

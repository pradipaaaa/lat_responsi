import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/app_states.dart';
import 'package:news_app/features/spaceflight/data/spaceflight_api.dart';
import 'package:news_app/features/spaceflight/models/content_category.dart';
import 'package:news_app/features/spaceflight/models/spaceflight_item.dart';
import 'package:news_app/features/spaceflight/pages/detail_page.dart';
import 'package:news_app/features/spaceflight/widgets/item_card.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({required this.category, super.key});

  final ContentCategory category;

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  late Future<List<SpaceflightItem>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = SpaceflightApi.fetchItems(widget.category);
  }

  void _refreshItems() {
    setState(() {
      _futureItems = SpaceflightApi.fetchItems(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _refreshItems,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<SpaceflightItem>>(
        future: _futureItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingState(message: 'Memuat data...');
          }

          if (snapshot.hasError) {
            return ErrorState(
              message: snapshot.error.toString(),
              onRetry: _refreshItems,
            );
          }

          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return EmptyState(
              title: 'Data kosong',
              message:
                  'Tidak ada data ${widget.category.title.toLowerCase()} saat ini.',
              onRetry: _refreshItems,
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              _refreshItems();
              await _futureItems;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(14),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                return ItemCard(
                  item: item,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            DetailPage(category: widget.category, item: item),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

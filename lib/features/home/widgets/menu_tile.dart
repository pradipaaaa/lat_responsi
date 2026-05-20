import 'package:flutter/material.dart';
import 'package:news_app/features/spaceflight/models/content_category.dart';
import 'package:news_app/features/spaceflight/pages/item_list_page.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({required this.category, super.key});

  final ContentCategory category;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ItemListPage(category: category)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: category.color.withAlpha(31),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(category.icon, color: category.color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

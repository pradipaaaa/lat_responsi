import 'package:flutter/material.dart';
import 'package:news_app/core/utils/date_formatter.dart';
import 'package:news_app/features/spaceflight/models/spaceflight_item.dart';
import 'package:news_app/features/spaceflight/widgets/icon_text.dart';

class MetadataRow extends StatelessWidget {
  const MetadataRow({required this.item, super.key});

  final SpaceflightItem item;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelMedium?.copyWith(
      color: Colors.black54,
      fontWeight: FontWeight.w600,
    );

    return Wrap(
      spacing: 8,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        IconText(
          icon: Icons.public,
          text: item.newsSite.isEmpty ? 'Unknown' : item.newsSite,
          style: style,
        ),
        IconText(
          icon: Icons.calendar_today_outlined,
          text: formatDate(item.publishedAt),
          style: style,
        ),
      ],
    );
  }
}

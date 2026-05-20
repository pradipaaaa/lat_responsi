import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({
    required this.icon,
    required this.text,
    required this.style,
    super.key,
  });

  final IconData icon;
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 220),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.black45),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}

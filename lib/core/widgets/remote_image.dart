import 'package:flutter/material.dart';

class RemoteImage extends StatelessWidget {
  const RemoteImage({required this.imageUrl, required this.fit, super.key});

  final String imageUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return const ImageFallback();
    }

    return Image.network(
      imageUrl,
      fit: fit,
      errorBuilder: (_, _, _) => const ImageFallback(),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const ImageFallback(isLoading: true);
      },
    );
  }
}

class ImageFallback extends StatelessWidget {
  const ImageFallback({this.isLoading = false, super.key});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFE7EEF0),
      child: Center(
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(
                Icons.image_not_supported_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
      ),
    );
  }
}

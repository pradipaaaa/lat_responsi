import 'package:flutter/material.dart';

class ContentCategory {
  const ContentCategory({
    required this.title,
    required this.singularTitle,
    required this.description,
    required this.endpoint,
    required this.icon,
    required this.color,
  });

  final String title;
  final String singularTitle;
  final String description;
  final String endpoint;
  final IconData icon;
  final Color color;
}

const contentCategories = [
  ContentCategory(
    title: 'News',
    singularTitle: 'News',
    description: 'Artikel berita terbaru tentang misi dan teknologi antariksa.',
    endpoint: 'articles',
    icon: Icons.newspaper_outlined,
    color: Color(0xFF1B6B6F),
  ),
  ContentCategory(
    title: 'Blogs',
    singularTitle: 'Blog',
    description: 'Tulisan blog dari berbagai sumber resmi dan komunitas.',
    endpoint: 'blogs',
    icon: Icons.article_outlined,
    color: Color(0xFF8057A8),
  ),
  ContentCategory(
    title: 'Reports',
    singularTitle: 'Report',
    description: 'Laporan dan publikasi yang berkaitan dengan spaceflight.',
    endpoint: 'reports',
    icon: Icons.assessment_outlined,
    color: Color(0xFFB15A31),
  ),
];

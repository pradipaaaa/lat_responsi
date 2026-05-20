import 'package:flutter/material.dart';
import 'package:news_app/features/auth/data/auth_repository.dart';
import 'package:news_app/features/auth/pages/login_page.dart';
import 'package:news_app/features/home/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final username = await AuthRepository.currentUsernameIfLoggedIn();

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) =>
            username != null ? HomePage(username: username) : const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

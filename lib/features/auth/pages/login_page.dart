import 'package:flutter/material.dart';
import 'package:news_app/core/utils/validators.dart';
import 'package:news_app/features/auth/data/auth_repository.dart';
import 'package:news_app/features/auth/pages/register_page.dart';
import 'package:news_app/features/auth/widgets/auth_scaffold.dart';
import 'package:news_app/features/home/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    final username = _usernameController.text.trim();
    final result = await AuthRepository.login(
      username: username,
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (!result.isSuccess) {
      _showMessage(_messageForFailure(result.failure));
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomePage(username: username)),
    );
  }

  String _messageForFailure(LoginFailure? failure) {
    return switch (failure) {
      LoginFailure.accountMissing =>
        'Belum ada akun. Silakan register terlebih dahulu.',
      LoginFailure.invalidCredentials => 'Username atau password tidak sesuai.',
      null => 'Login gagal.',
    };
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Login',
      subtitle: 'Masuk untuk melihat news, blogs, dan reports terbaru.',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              validator: requiredValidator,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _passwordController,
              obscureText: _isPasswordHidden,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  tooltip: _isPasswordHidden
                      ? 'Tampilkan password'
                      : 'Sembunyikan password',
                  onPressed: () {
                    setState(() => _isPasswordHidden = !_isPasswordHidden);
                  },
                  icon: Icon(
                    _isPasswordHidden
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
              onFieldSubmitted: (_) => _login(),
              validator: requiredValidator,
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: _login,
              icon: const Icon(Icons.login),
              label: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const RegisterPage()));
              },
              child: const Text('Belum punya akun? Register'),
            ),
          ],
        ),
      ),
    );
  }
}

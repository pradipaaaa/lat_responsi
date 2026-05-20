import 'package:flutter/material.dart';
import 'package:news_app/features/auth/data/auth_repository.dart';
import 'package:news_app/features/auth/widgets/auth_scaffold.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordHidden = true;
  bool _isConfirmHidden = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    await AuthRepository.register(
      username: _usernameController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Register berhasil. Silakan login.')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Register',
      subtitle: 'Buat akun sederhana yang disimpan memakai SharedPreferences.',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person_add_alt_1_outlined),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) return 'Username wajib diisi.';
                if (text.length < 3) return 'Minimal 3 karakter.';
                return null;
              },
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
              textInputAction: TextInputAction.next,
              validator: (value) {
                if ((value ?? '').isEmpty) return 'Password wajib diisi.';
                if ((value ?? '').length < 4) return 'Minimal 4 karakter.';
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _isConfirmHidden,
              decoration: InputDecoration(
                labelText: 'Konfirmasi Password',
                prefixIcon: const Icon(Icons.verified_user_outlined),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  tooltip: _isConfirmHidden
                      ? 'Tampilkan password'
                      : 'Sembunyikan password',
                  onPressed: () {
                    setState(() => _isConfirmHidden = !_isConfirmHidden);
                  },
                  icon: Icon(
                    _isConfirmHidden
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
              onFieldSubmitted: (_) => _register(),
              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return 'Konfirmasi password wajib diisi.';
                }
                if (value != _passwordController.text) {
                  return 'Konfirmasi password tidak sama.';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: _register,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

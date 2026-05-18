import 'package:flutter/material.dart';
import 'package:june/Services/auth_service.dart';
import 'package:june/Widgets/Cards/sign_up_card.dart';
import 'package:june/routes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      await _authService.signUp(
        _emailController.text.trim(),
        _passwordController.text,
        name: _nameController.text.trim(),
      );
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(Routes.homePage);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SignUpCard(
            nameController: _nameController,
            passwordController: _passwordController,
            emailController: _emailController,
            onSignUpButtonPressed: _isLoading ? null : _signUp,
          ),
          //TERMS AND CONDITIONS A AGREELEMEKLE OLAN KISMI YAPMAYI UNUTMAAAA
        ),
      ),
    );
  }
}

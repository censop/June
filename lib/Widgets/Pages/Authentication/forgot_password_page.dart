import 'package:flutter/material.dart';
import 'package:june/Widgets/Cards/forgot_password_card.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ForgotPasswordCard(
            emailController: _emailController,
            onResetPasswordPressed: () {},
          ),
          //TERMS AND CONDITIONS A AGREELEMEKLE OLAN KISMI YAPMAYI UNUTMAAAA
        ),
      ),
    );
  }
}
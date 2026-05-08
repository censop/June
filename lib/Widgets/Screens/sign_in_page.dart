import 'package:flutter/material.dart';
import 'package:june/Widgets/Cards/sign_in_card.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SignInCard(
            passwordController: _passwordController,
            emailController: _emailController,
            onSignInButtonPressed: () {},
          ),
          //TERMS AND CONDITIONS A AGREELEMEKLE OLAN KISMI YAPMAYI UNUTMAAAA
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:june/Widgets/Cards/sign_up_card.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SignUpCard( ///TODO: SO VERY IMPORTANT!!!! PUSHNAMED YERİNEREPLACED KULLAN LOGIC GELİNCE!!
            nameController: _nameController,
            passwordController: _passwordController,
            emailController: _emailController,
            onSignUpButtonPressed: () {},
          ),
          //TERMS AND CONDITIONS A AGREELEMEKLE OLAN KISMI YAPMAYI UNUTMAAAA
        ),
      ),
    );
  }
}
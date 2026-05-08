
import 'package:flutter/material.dart';
import 'package:june/Widgets/Buttons/custom_primary_elevated_button.dart';
import 'package:june/Widgets/Cards/custom_default_card.dart';
import 'package:june/Widgets/Form/custom_text_form_field.dart';
import 'package:june/routes.dart';

class SignUpCard extends StatefulWidget {
  const SignUpCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    this.onSignUpButtonPressed
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function()? onSignUpButtonPressed;


  @override
  State<SignUpCard> createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  bool seePassword = true;

  @override
  Widget build(BuildContext context) {
    return CustomDefaultCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20,24,29,24),
        child: Column(
          mainAxisSize: MainAxisSize.min ,
          children: [
            Text(
              "Create Account",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(),
            ),
            SizedBox(height: 24,),
            CustomTextFormField(
              controller: widget.nameController,
              title: "Name",
            ),
            SizedBox(height: 20,),
            CustomTextFormField(
              controller: widget.emailController,
              title: "Email",
            ),
            SizedBox(height: 20,),
            CustomTextFormField(
              controller: widget.passwordController,
              title: "Password",
              suffixIcon: IconButton(
                icon: Icon(
                  seePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    seePassword = !seePassword;
                  });
                },
              ),
              obscureText: seePassword,
            ),
            SizedBox(height: 24,),
            CustomElevatedPrimaryButton(
              onPressed: widget.onSignUpButtonPressed, 
              text: "Sign Up"
            ),
            SizedBox(height: 24,),
            Text(
              "Already have an account?",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            GestureDetector(
              child: Text(
                "Sign In",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.signInPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
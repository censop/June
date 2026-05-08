import 'package:flutter/material.dart';
import 'package:june/Widgets/Buttons/custom_primary_elevated_button.dart';
import 'package:june/Widgets/Cards/custom_default_card.dart';
import 'package:june/Widgets/Form/custom_text_form_field.dart';
import 'package:june/routes.dart';

class SignInCard extends StatefulWidget {
  const SignInCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    this.onSignInButtonPressed
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function()? onSignInButtonPressed;
  @override
  State<SignInCard> createState() => _SignInCardState();
}

class _SignInCardState extends State<SignInCard> {
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
              "Sign In",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(),
            ),
            SizedBox(height: 24,),
            CustomTextFormField(
              controller: widget.emailController,
              title: "Email",
            ),
            SizedBox(height: 20,),
            CustomTextFormField(
              controller: widget.passwordController,
              title: "Password",
              suffixWidget: IconButton(
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
            SizedBox(height: 8,),
            GestureDetector(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot passoword?",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.forgotPasswordPage);
              },
            ),
            SizedBox(height: 24,),
            CustomElevatedPrimaryButton(
              onPressed: widget.onSignInButtonPressed, 
              text: "Sign In"
            ),
            SizedBox(height: 24,),
            Text(
              "Don't have an account?",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            GestureDetector(
              child: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.signUpPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
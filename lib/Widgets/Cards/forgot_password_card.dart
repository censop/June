import 'package:flutter/material.dart';
import 'package:june/Widgets/Cards/custom_default_card.dart';
import 'package:june/Widgets/Form/custom_text_form_field.dart';
import 'package:june/routes.dart';

class ForgotPasswordCard extends StatefulWidget {
  const ForgotPasswordCard({
    super.key,
    required this.emailController,
    this.onResetPasswordPressed
  });

  final TextEditingController emailController;
  final Function()? onResetPasswordPressed;

  @override
  State<ForgotPasswordCard> createState() => _ForgotPasswordCardState();
}

class _ForgotPasswordCardState extends State<ForgotPasswordCard> {
  @override
  Widget build(BuildContext context) {
    return CustomDefaultCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20,24,29,24),
        child: Column(
          mainAxisSize: MainAxisSize.min ,
          children: [
            Text(
              "Reset Password",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(),
            ),
            SizedBox(height: 24,),
            CustomTextFormField(
              controller: widget.emailController,
              title: "Email",
              suffixWidget: GestureDetector(
                onTap: () {
                  debugPrint("send reset pass mail pressed");
                }, 
                child: Icon(
                  Icons.arrow_forward_ios
                )
                ),
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
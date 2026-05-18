import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:june/Services/auth_service.dart';
import 'package:june/Widgets/Auth/auth_text_field.dart';
import 'package:june/routes.dart';
import 'package:june/Widgets/Auth/dot_logo_widget.dart';
import 'package:june/Widgets/Auth/password_strength_bar.dart';
import 'package:june/Widgets/Auth/social_auth_button.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;
  bool _isLoading = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  Future<void> _signUp() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      await _authService.signUp(
        _emailController.text.trim(),
        _passwordController.text,
        name: _nameController.text.trim(),
      );
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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.signUpBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              _buildFormCard(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 52, 24, 36),
      child: Column(
        children: [
          const DotLogoWidget(),
          const SizedBox(height: 24),
          Text(
            'Join the Flow',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Step into your most productive self.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: MyTheme.signUpSubtitle,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: MyTheme.signUpBg.withValues(alpha: 0.8),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            label: 'FULL NAME',
            hint: 'Alex Rivers',
            leadingIcon: Icons.person_outline,
            controller: _nameController,
          ),
          const SizedBox(height: 16),
          AuthTextField(
            label: 'EMAIL ADDRESS',
            hint: 'alex@flow.com',
            leadingIcon: Icons.mail_outline,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          AuthTextField(
            label: 'PASSWORD',
            hint: '••••••••',
            leadingIcon: Icons.lock_outline,
            obscureText: _obscurePassword,
            controller: _passwordController,
            trailing: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: MyTheme.signUpSubtitle,
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          const SizedBox(height: 10),
          const PasswordStrengthBar(strength: PasswordStrength.strong),
          const SizedBox(height: 24),
          _buildCreateAccountButton(),
          const SizedBox(height: 24),
          _buildDivider(),
          const SizedBox(height: 24),
          _buildSocialButtons(),
        ],
      ),
    );
  }

  Widget _buildCreateAccountButton() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [MyTheme.signUpGradientStart, MyTheme.signUpGradientEnd],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : _signUp,
          borderRadius: BorderRadius.circular(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _isLoading
                ? const [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  ]
                : const [
                    Text(
                      'CREATE ACCOUNT',
                      style: TextStyle(
                        fontFamily: MyTheme.interFont,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(color: MyTheme.signUpFieldBorder, thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR CONTINUE WITH',
            style: TextStyle(
              fontFamily: MyTheme.interFont,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
              color: MyTheme.signUpSubtitle,
            ),
          ),
        ),
        Expanded(
          child: Divider(color: MyTheme.signUpFieldBorder, thickness: 1),
        ),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      children: [
        Expanded(
          child: SocialAuthButton(
            icon: const _GoogleIcon(),
            label: 'GOOGLE',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SocialAuthButton(
            icon: const _AppleIcon(),
            label: 'APPLE',
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Center(
        child: RichText(
          text: TextSpan(
            text: 'Already have an account? ',
            style: const TextStyle(
              fontFamily: MyTheme.interFont,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: MyTheme.signUpSubtitle,
            ),
            children: [
              TextSpan(
                text: 'Log in',
                style: const TextStyle(
                  color: MyTheme.signUpTeal,
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.of(context).pushNamed(Routes.signInPage),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFDFE1E5), width: 1.2),
      ),
      child: const Center(
        child: Text(
          'G',
          style: TextStyle(
            fontFamily: MyTheme.interFont,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(0xFF4285F4),
            height: 1.0,
          ),
        ),
      ),
    );
  }
}

class _AppleIcon extends StatelessWidget {
  const _AppleIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(painter: _ApplePainter()),
    );
  }
}

class _ApplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyTheme.neutralColor
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Apple body
    final body = Path()
      ..moveTo(w * 0.38, h * 0.24)
      ..cubicTo(w * 0.10, h * 0.24, w * 0.06, h * 0.50, w * 0.06, h * 0.64)
      ..cubicTo(w * 0.06, h * 0.85, w * 0.18, h * 1.00, w * 0.38, h * 1.00)
      ..cubicTo(w * 0.44, h * 1.00, w * 0.48, h * 0.96, w * 0.50, h * 0.96)
      ..cubicTo(w * 0.52, h * 0.96, w * 0.56, h * 1.00, w * 0.62, h * 1.00)
      ..cubicTo(w * 0.82, h * 1.00, w * 0.94, h * 0.85, w * 0.94, h * 0.64)
      ..cubicTo(w * 0.94, h * 0.50, w * 0.90, h * 0.24, w * 0.62, h * 0.24)
      ..cubicTo(w * 0.56, h * 0.24, w * 0.52, h * 0.28, w * 0.50, h * 0.30)
      ..cubicTo(w * 0.48, h * 0.28, w * 0.44, h * 0.24, w * 0.38, h * 0.24)
      ..close();

    canvas.drawPath(body, paint);

    // Leaf
    final leaf = Path()
      ..moveTo(w * 0.50, h * 0.28)
      ..cubicTo(w * 0.53, h * 0.12, w * 0.70, h * 0.04, w * 0.74, h * 0.08)
      ..cubicTo(w * 0.68, h * 0.20, w * 0.55, h * 0.24, w * 0.50, h * 0.28)
      ..close();

    canvas.drawPath(leaf, paint);
  }

  @override
  bool shouldRepaint(_ApplePainter old) => false;
}

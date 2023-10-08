import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:gardenguru/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _WelcomeBackPage();
  }
}

class _WelcomeBackPage extends StatefulWidget {
  static const Color customColor = Color(0xFF55604C);

  const _WelcomeBackPage();

  @override
  State<_WelcomeBackPage> createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<_WelcomeBackPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = userCredential.user;
      // Navigate to the next screen or perform other actions after successful login

      print('User logged in: ${user?.email}');
      context.router.push(NavigationBarRoute());
    } catch (e) {
      print('Error: $e');
      // Handle login errors, e.g., display an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const TitleText(),
              const SizedBox(height: 56),
              EmailInput(emailController: _emailController),
              const SizedBox(height: 16),
              PasswordInput(passwordController: _passwordController),
              const SizedBox(height: 30),
              const ForgotPasswordText(),
              const SizedBox(height: 7),
              LoginButton(onPress: _signInWithEmailAndPassword),
              // const SizedBox(height: 30),
              // const DecorImage(),
              // const SizedBox(height: 30),
              // const GoogleSignInButton(),
              const SizedBox(height: 20),
              const SignUpText(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class TitleText extends StatelessWidget {
  const TitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 122),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Grow Green',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 24,
                            color: Color(0xFF55604C),
                            fontWeight: FontWeight.bold))),
              ],
            ),
            Text(
              'Live Fresh',
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  }
}

class EmailInput extends StatefulWidget {
  final TextEditingController _emailController;

  const EmailInput({super.key, required TextEditingController emailController})
      : _emailController = emailController;

  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email address',
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold))),
          const SizedBox(height: 15),
          SizedBox(
            height: 43.0,
            child: TextField(
              controller: widget._emailController,
              decoration: InputDecoration(
                hintText: 'xalo@gmail.com',
                hintStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  fontSize: 13,
                )),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFFD9D9D9), width: 2.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordInput extends StatefulWidget {
  final TextEditingController _passwordController;

  const PasswordInput(
      {super.key, required TextEditingController passwordController})
      : _passwordController = passwordController;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isObscured = true;

  void _togglePasswordVisibility() {
    _isObscured = !_isObscured;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: GoogleFonts.inter(
                textStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 43.0,
            child: TextField(
              controller: widget._passwordController,
              obscureText: _isObscured,
              decoration: InputDecoration(
                hintText: 'At least 8 characters',
                hintStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(fontSize: 14)),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFFD9D9D9), width: 2.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 12.0),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFFD9D9D9),
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //
      },
      child: Text(
        'Forgot password?',
        style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 13)),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback onPress;

  const LoginButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      height: 43,
      child: ElevatedButton(
        onPressed: () => onPress(),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(_WelcomeBackPage.customColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
        child: Text(
          'Log in',
          style: GoogleFonts.inter(
              textStyle: const TextStyle(fontSize: 15, color: Colors.white)),
        ),
      ),
    );
  }
}

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Do you have an account?',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            context.replaceRoute(const SignUpRoute());
          },
          child: Text(
            ' Sign up',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 15,
                color: _WelcomeBackPage.customColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

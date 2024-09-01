import 'package:chatwave/services/auth/auth_service.dart';
import 'package:chatwave/components/button_field.dart';
import 'package:chatwave/components/text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  // email and password controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwconfirmController = TextEditingController();

  // navigate to register page
  final void Function()? onTap;
  RegisterPage({
    super.key,
    required this.onTap,
  });

  // login method
  void register(BuildContext context) {
    // get auth service
    final _auth = AuthService();
    // if password and confirm password matched
    if (_pwController.text == _pwconfirmController.text) {
      try {
        _auth.signUpWithEmailAndPassword(
          _emailController.text,
          _pwController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.amber,
            titlePadding: const EdgeInsets.all(45),
            titleTextStyle: const TextStyle(
              color: Colors.red,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            title: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
    // if password no match display message
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          backgroundColor: Colors.amber,
          titlePadding: EdgeInsets.all(45),
          titleTextStyle: TextStyle(
            color: Colors.red,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          title: Text(
            "Password Not Matched!",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the Theme data
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Scaffold(
      backgroundColor: surfaceColor,
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 50),
            // welcome message
            Text(
              'Let\'s create an Account.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            // email input
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            // password input
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _pwController,
            ),
            // re enter password
            MyTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _pwconfirmController,
            ),
            const SizedBox(height: 25),
            // register button
            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have a account? '),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    'Login now.',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

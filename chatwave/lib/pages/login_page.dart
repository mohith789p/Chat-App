import 'package:chatwave/services/auth/auth_service.dart';
import 'package:chatwave/components/button_field.dart';
import 'package:chatwave/components/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // email and password controller
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _pwController = TextEditingController();

  // Track whether the password is visible or not
  bool _isPasswordVisible = false;

  // login method
  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // Check if any field is empty
    if (_emailController.text.trim().isEmpty ||
        _pwController.text.trim().isEmpty) {
      // Show dialog for missing fields
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.amber[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min, // Compact layout
            crossAxisAlignment: CrossAxisAlignment.start, // Align text
            children: [
              Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Input Required",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                "Please fill all fields before proceeding.",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      try {
        // Try to login
        await authService.signInWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
      } catch (e) {
        // If login fails, show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.amber[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min, // Compact layout
              crossAxisAlignment: CrossAxisAlignment.start, // Align text
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 28,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Login Failed",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Text(
                  "Your email or password doesn't match. Please check your credentials and try again.",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the Theme data
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Scaffold(
      backgroundColor: surfaceColor,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Login',
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // logo
                    Icon(
                      Icons.message,
                      size: 60,
                      color: Colors.purple.shade500,
                    ),
                    const SizedBox(height: 50),
                    // welcome message
                    Text(
                      'Welcome to chatWave!',
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
                      obscureText: !_isPasswordVisible,
                      controller: _pwController,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible =
                                !_isPasswordVisible; // Toggle visibility
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    // login button
                    MyButton(
                      text: "Login",
                      onTap: () => login(context),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('New User? '),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Register now.',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

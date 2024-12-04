import 'package:chatwave/services/auth/auth_service.dart';
import 'package:chatwave/components/button_field.dart';
import 'package:chatwave/components/text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // email and password controller
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _pwController = TextEditingController();

  final TextEditingController _pwconfirmController = TextEditingController();

// Track whether the password is visible or not
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // login method
  void register(BuildContext context) {
    // get auth service
    final auth = AuthService();
    // if password and confirm password matched
    if (_pwController.text == _pwconfirmController.text) {
      // Check if any of the fields are empty
      if (_emailController.text.trim().isEmpty ||
          _pwController.text.trim().isEmpty ||
          _pwconfirmController.text.trim().isEmpty) {
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
          auth.signUpWithEmailAndPassword(
            _emailController.text.trim(),
            _pwController.text.trim(),
          );
          // Optionally, show success feedback or navigate
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.green[100],
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
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Registration Successful",
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
                    "Your account has been created successfully. You can now log in.",
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
        } catch (e) {
          // Handle sign-up errors
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.amber[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min, // Compact layout
                crossAxisAlignment: CrossAxisAlignment.start, // Align text
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Registration Failed",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    e.toString(),
                    style: const TextStyle(
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
    } else {
      // Handle password mismatch error
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
                      "Registration Failed",
                      style: const TextStyle(
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
                "Passwords do not match. Please try again.",
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

  @override
  Widget build(BuildContext context) {
    // Access the Theme data
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Scaffold(
      backgroundColor: surfaceColor,
      appBar: AppBar(
        title: const Center(
          child: Text('Register'),
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

                    // re-enter password
                    MyTextField(
                      hintText: "Confirm Password",
                      obscureText: !_isConfirmPasswordVisible,
                      controller: _pwconfirmController,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible; // Toggle visibility
                          });
                        },
                      ),
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
                        const Text('Already have an account? '),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Login now.',
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

import 'package:flutter/material.dart';
import 'selection_screen.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to FlowSync",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                label: "Email",
                controller: _emailController,
                icon: Icons.email,
              ),
              CustomTextField(
                label: "Password",
                controller: _passwordController,
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Login / Sign Up",
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectionScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

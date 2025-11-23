import 'package:flutter/material.dart';
import '../../../../app.dart';

/// Login Screen
///
/// LEARN: This screen allows users to log in to the app.
/// For now, it's a placeholder that navigates to home.
///
/// Later, this will include:
/// - Email/password input fields
/// - Login button
/// - Sign up link
/// - Social login options

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  /// Navigate to home screen
  ///
  /// LEARN: For now, we just navigate to home.
  /// Later, this will be replaced with actual login logic.
  void _navigateToHome(BuildContext context) {
    final themeToggle = BoosApp.getThemeToggle() ?? () {};
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => MyHomePage(onThemeToggle: themeToggle)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Login Form Placeholder
              Text(
                'Login Screen',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 32),
              Text(
                'This is a placeholder for the login screen.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Temporary Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _navigateToHome(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Continue to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

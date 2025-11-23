import 'package:flutter/material.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../core/constants/route_constants.dart';

/// Onboarding Screen
///
/// LEARN: This screen is shown to first-time users.
/// It introduces the app and its features.
///
/// After the user completes onboarding, we mark it as seen
/// and navigate to the login screen.

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  /// Mark onboarding as completed
  ///
  /// LEARN: We save a flag to local storage indicating the user
  /// has seen onboarding. This prevents showing it again.
  Future<void> _completeOnboarding(BuildContext context) async {
    final localStorage = LocalStorage();
    await localStorage.saveBool('has_seen_onboarding', true);

    // Navigate to login screen
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(RouteConstants.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              const Icon(Icons.business, size: 120, color: Colors.green),
              const SizedBox(height: 32),

              // Welcome Text
              Text(
                'Welcome to Boos',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              Text(
                'Your business management solution',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Get Started Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _completeOnboarding(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Get Started'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

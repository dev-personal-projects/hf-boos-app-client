import 'package:flutter/material.dart';
import '../../../../core/constants/asset_constants.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../app.dart';

/// Splash Screen
///
/// LEARN: This is the first screen users see when the app launches.
/// It serves multiple purposes:
/// 1. Branding - Shows app logo
/// 2. Initialization - Gives time for app setup
/// 3. Navigation - Routes users to the right screen based on their state
///
/// The splash screen:
/// - Displays logo with smooth animations
/// - Checks authentication status
/// - Checks if user has seen onboarding
/// - Navigates to appropriate screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  /// Animation controller for logo animations
  ///
  /// LEARN: AnimationController manages animations.
  /// SingleTickerProviderStateMixin provides the ticker needed for animations.
  late AnimationController _animationController;

  /// Fade animation for logo
  ///
  /// LEARN: Fade animation changes opacity from 0 (invisible) to 1 (visible).
  late Animation<double> _fadeAnimation;

  /// Scale animation for logo
  ///
  /// LEARN: Scale animation changes size from 0.8 (smaller) to 1.0 (normal).
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    //
    // LEARN: vsync: this tells Flutter when to update the animation.
    // duration: How long the animation takes (1.5 seconds).
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Create fade animation
    //
    // LEARN: Tween defines the range of values (0.0 to 1.0).
    // CurvedAnimation makes the animation smooth (not linear).
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Create scale animation
    //
    // LEARN: Scale from 0.8 (80% size) to 1.0 (100% size).
    // This creates a "zoom in" effect.
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Start animation
    _animationController.forward();

    // Navigate after animation and initialization
    //
    // LEARN: We wait for both:
    // 1. Animation to complete (1.5 seconds)
    // 2. Initialization checks (auth, onboarding)
    // Then navigate to the appropriate screen.
    _navigateToNextScreen();
  }

  @override
  void dispose() {
    // LEARN: Always dispose animation controllers to free resources.
    _animationController.dispose();
    super.dispose();
  }

  /// Navigate to the appropriate screen
  ///
  /// LEARN: This method:
  /// 1. Waits for minimum splash duration (2 seconds)
  /// 2. Checks if user is authenticated
  /// 3. Checks if user has seen onboarding
  /// 4. Navigates to the right screen
  Future<void> _navigateToNextScreen() async {
    // Wait for minimum splash duration (2 seconds)
    // This ensures users see the logo and branding
    await Future.delayed(const Duration(seconds: 2));

    // Check authentication and onboarding status
    final isAuthenticated = await _checkAuthentication();
    final hasSeenOnboarding = await _checkOnboarding();

    // Navigate based on user state
    //
    // LEARN: We use pushReplacement instead of push.
    // This removes the splash screen from the navigation stack,
    // so users can't go back to it.
    if (!mounted) return; // Check if widget is still mounted

    if (!hasSeenOnboarding) {
      // First-time user - show onboarding
      Navigator.of(context).pushReplacementNamed(RouteConstants.onboarding);
    } else if (!isAuthenticated) {
      // Not logged in - show login
      Navigator.of(context).pushReplacementNamed(RouteConstants.login);
    } else {
      // Logged in - show home
      // LEARN: We get the theme toggle function from the app state.
      // The static method safely accesses the app state.
      final themeToggle = BoosApp.getThemeToggle() ?? () {};

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyHomePage(onThemeToggle: themeToggle),
        ),
      );
    }
  }

  /// Check if user is authenticated
  ///
  /// LEARN: We check if a JWT token exists in secure storage.
  /// If token exists, user is authenticated.
  Future<bool> _checkAuthentication() async {
    try {
      final secureStorage = SecureStorage();
      final token = await secureStorage.get('auth_token');
      return token != null && token.isNotEmpty;
    } catch (e) {
      // If there's an error, assume not authenticated
      return false;
    }
  }

  /// Check if user has seen onboarding
  ///
  /// LEARN: We check local storage for onboarding completion flag.
  /// If flag exists, user has seen onboarding.
  Future<bool> _checkOnboarding() async {
    try {
      final localStorage = LocalStorage();
      return localStorage.getBool('has_seen_onboarding') ?? false;
    } catch (e) {
      // If there's an error, assume not seen (show onboarding)
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get theme brightness for theme-aware styling
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // LEARN: We use a gradient background for a professional look.
      // The gradient goes from primary green to a slightly darker shade.
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [AppColors.primaryGreenDark, AppColors.secondaryGreenDark]
                : [AppColors.primaryGreenLight, AppColors.secondaryGreenLight],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo
                //
                // LEARN: AnimatedBuilder rebuilds when animation values change.
                // This creates smooth animation effects.
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: _buildCircularLogo(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppConstants.spacingXL),

                // Loading Indicator
                //
                // LEARN: CircularProgressIndicator shows a spinning loader.
                // We use white color to contrast with green background.
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),

                const SizedBox(height: AppConstants.spacingL),

                // App Name
                //
                // LEARN: We show the app name below the logo.
                // This reinforces branding.
                Text(
                  'Boos',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build circular logo
  ///
  /// LEARN: This method creates a circular logo from the rectangular image.
  /// We use ClipOval to make it circular, and add a white container
  /// with shadow for depth.
  Widget _buildCircularLogo() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipOval(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            AssetConstants.logo,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // LEARN: If image fails to load, show a placeholder icon.
              // This prevents crashes if the logo file is missing.
              return const Icon(Icons.business, size: 80, color: Colors.grey);
            },
          ),
        ),
      ),
    );
  }
}

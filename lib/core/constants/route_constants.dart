/// Route Constants
///
/// LEARN: This file contains all route names/paths used for navigation.
/// Using constants for routes:
/// 1. Prevents typos in route names
/// 2. Easy refactoring (change route once)
/// 3. Autocomplete support
/// 4. Type safety
///
/// LEARN: Routes are like URLs in a web app. They define where users can navigate.
/// In Flutter, we use routes to navigate between screens.
library;

class RouteConstants {
  // Private constructor prevents creating instances
  RouteConstants._();

  // ============================================================================
  // ROOT ROUTES
  // ============================================================================

  /// Root route (initial route)
  /// This is the first screen shown when app opens
  static const String root = '/';

  /// Splash screen route
  /// Shown while app is initializing
  static const String splash = '/splash';

  /// Onboarding route
  /// Shown to new users (first time only)
  static const String onboarding = '/onboarding';

  // ============================================================================
  // AUTHENTICATION ROUTES
  // ============================================================================

  /// Login screen route
  static const String login = '/login';

  /// Signup screen route
  static const String signup = '/signup';

  /// Business registration route
  /// Shown after signup to register a business
  static const String businessRegistration = '/business/register';

  /// Forgot password route
  static const String forgotPassword = '/forgot-password';

  /// Reset password route
  static const String resetPassword = '/reset-password';

  // ============================================================================
  // MAIN APP ROUTES
  // ============================================================================

  /// Home/Dashboard route
  /// Main screen after login
  static const String home = '/home';

  /// Documents list route
  /// Shows all documents (invoices, receipts, quotations)
  static const String documents = '/documents';

  /// Create document route
  /// Form to create new document
  static const String createDocument = '/documents/create';

  /// Document details route
  /// View/edit a specific document
  /// Use with: RouteConstants.documentDetails.replaceAll(':id', documentId)
  static const String documentDetails = '/documents/:id';

  /// Profile route
  /// User profile and settings
  static const String profile = '/profile';

  /// Settings route
  /// App settings and preferences
  static const String settings = '/settings';

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Get document details route with ID
  ///
  /// LEARN: This is a helper method that replaces the :id placeholder
  /// with an actual document ID.
  ///
  /// Example:
  /// final route = RouteConstants.getDocumentDetailsRoute('123');
  /// Result: '/documents/123'
  ///
  /// Parameters:
  /// - id: The document ID
  ///
  /// Returns: Route path with ID
  static String getDocumentDetailsRoute(String id) {
    return documentDetails.replaceAll(':id', id);
  }

  /// Check if route requires authentication
  ///
  /// LEARN: This helper method determines if a route needs the user
  /// to be logged in. Useful for route guards.
  ///
  /// Parameters:
  /// - route: The route path to check
  ///
  /// Returns: true if route requires auth, false otherwise
  static bool requiresAuth(String route) {
    // Routes that don't require authentication
    const publicRoutes = [
      root,
      splash,
      onboarding,
      login,
      signup,
      forgotPassword,
      resetPassword,
    ];

    return !publicRoutes.contains(route);
  }
}

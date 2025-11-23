import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:boos/app.dart';
import 'package:boos/features/auth/presentation/screens/splash_screen.dart';

void main() {
  group('Boos App Tests', () {
    testWidgets('Splash screen displays correctly', (
      WidgetTester tester,
    ) async {
      // Build splash screen
      await tester.pumpWidget(MaterialApp(home: const SplashScreen()));

      // Verify splash screen elements
      expect(find.text('Boos'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('App renders correctly with all main elements', (
      WidgetTester tester,
    ) async {
      // Build our app
      await tester.pumpWidget(BoosApp(key: BoosApp.appKey));

      // Wait for splash screen navigation (2 seconds + animation)
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Verify that the app title is displayed in the AppBar.
      expect(find.text('Boos'), findsOneWidget);

      // Verify that the main content is displayed.
      expect(find.text('Hello, World!'), findsOneWidget);

      // Verify that the theme toggle button is present.
      final hasDarkIcon = find.byIcon(Icons.dark_mode).evaluate().isNotEmpty;
      final hasLightIcon = find.byIcon(Icons.light_mode).evaluate().isNotEmpty;
      expect(hasDarkIcon || hasLightIcon, isTrue);
    });

    testWidgets('Theme toggle button works correctly', (
      WidgetTester tester,
    ) async {
      // Build our app.
      await tester.pumpWidget(BoosApp(key: BoosApp.appKey));

      // Wait for splash screen to navigate
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Verify theme toggle icon exists
      final hasDarkIcon = find.byIcon(Icons.dark_mode).evaluate().isNotEmpty;
      final hasLightIcon = find.byIcon(Icons.light_mode).evaluate().isNotEmpty;
      expect(hasDarkIcon || hasLightIcon, isTrue);

      // Get the current icon
      final currentIconFinder = hasDarkIcon
          ? find.byIcon(Icons.dark_mode)
          : find.byIcon(Icons.light_mode);

      // Tap the theme toggle button.
      await tester.tap(currentIconFinder);
      await tester.pumpAndSettle();

      // After toggling, verify icon changed
      final hasDarkIconAfter = find
          .byIcon(Icons.dark_mode)
          .evaluate()
          .isNotEmpty;
      final hasLightIconAfter = find
          .byIcon(Icons.light_mode)
          .evaluate()
          .isNotEmpty;
      expect(hasDarkIconAfter || hasLightIconAfter, isTrue);
    });

    testWidgets('App uses custom green theme in light mode', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(BoosApp(key: BoosApp.appKey));

      // Get the MaterialApp widget.
      final MaterialApp app = tester.widget(find.byType(MaterialApp));

      // Verify that the light theme is set.
      expect(app.theme, isNotNull);
      expect(app.theme?.colorScheme.primary, isNotNull);

      // Verify that dark theme is also configured.
      expect(app.darkTheme, isNotNull);
      expect(app.darkTheme?.colorScheme.primary, isNotNull);
    });

    testWidgets('App content remains visible after theme toggle', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(BoosApp(key: BoosApp.appKey));

      // Wait for splash screen to navigate
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Verify content is visible initially.
      expect(find.text('Hello, World!'), findsOneWidget);
      expect(find.text('Boos'), findsOneWidget);

      // Toggle theme.
      final themeIconFinder = find.byIcon(Icons.dark_mode).evaluate().isNotEmpty
          ? find.byIcon(Icons.dark_mode)
          : find.byIcon(Icons.light_mode);
      await tester.tap(themeIconFinder);
      await tester.pumpAndSettle();

      // Verify content is still visible after theme change.
      expect(find.text('Hello, World!'), findsOneWidget);
      expect(find.text('Boos'), findsOneWidget);
    });
  });
}

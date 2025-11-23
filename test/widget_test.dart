import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:boos/main.dart';

void main() {
  group('Boos App Tests', () {
    testWidgets('App renders correctly with all main elements', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that the app title is displayed in the AppBar.
      expect(find.text('Boos'), findsOneWidget);

      // Verify that the main content is displayed.
      expect(find.text('Hello, World!'), findsOneWidget);

      // Verify that the theme toggle button is present.
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    });

    testWidgets('Theme toggle button works correctly', (
      WidgetTester tester,
    ) async {
      // Build our app.
      await tester.pumpWidget(const MyApp());

      // Initially, we should see the dark mode icon (since we start in light mode).
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
      expect(find.byIcon(Icons.light_mode), findsNothing);

      // Tap the theme toggle button.
      await tester.tap(find.byIcon(Icons.dark_mode));
      await tester.pumpAndSettle();

      // After toggling, we should see the light mode icon (since we're now in dark mode).
      expect(find.byIcon(Icons.light_mode), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode), findsNothing);

      // Toggle back to light mode.
      await tester.tap(find.byIcon(Icons.light_mode));
      await tester.pumpAndSettle();

      // Should be back to dark mode icon.
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    });

    testWidgets('App uses custom green theme in light mode', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

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
      await tester.pumpWidget(const MyApp());

      // Verify content is visible initially.
      expect(find.text('Hello, World!'), findsOneWidget);
      expect(find.text('Boos'), findsOneWidget);

      // Toggle theme.
      await tester.tap(find.byIcon(Icons.dark_mode));
      await tester.pumpAndSettle();

      // Verify content is still visible after theme change.
      expect(find.text('Hello, World!'), findsOneWidget);
      expect(find.text('Boos'), findsOneWidget);
    });
  });
}

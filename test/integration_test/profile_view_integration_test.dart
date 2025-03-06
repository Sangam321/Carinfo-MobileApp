import 'package:carinfo/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Profile screen integration test', (WidgetTester tester) async {
    app.main();

    // Wait for the app to load completely
    await tester.pumpAndSettle(Duration(seconds: 3));

    // Verify loading indicator appears
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the API call to complete and UI to update
    await tester.pumpAndSettle(Duration(seconds: 3));

    // Verify user data appears after fetching profile
    expect(find.textContaining('Name:'), findsOneWidget);
    expect(find.textContaining('Email:'), findsOneWidget);
    expect(find.textContaining('Role:'), findsOneWidget);
  });
}

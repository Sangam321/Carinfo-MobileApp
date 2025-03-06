import 'package:carinfo/features/auth/presentation/view/login_view.dart';
import 'package:carinfo/features/auth/presentation/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// Import your LoginView.

void main() {
  testWidgets('Renders RegisterView correctly', (WidgetTester tester) async {
    // Build the RegisterView widget
    await tester.pumpWidget(MaterialApp(home: RegisterView()));

    // Verify if the title is displayed
    expect(find.text('Create your Account'), findsOneWidget);

    // Verify the presence of the "Sign Up" button
    expect(find.text('Sign Up'), findsOneWidget);

    // Verify the presence of "Already have an account?" text
    expect(find.text('Already have an account?'), findsOneWidget);
  });

  testWidgets('Shows validation errors when fields are empty',
      (WidgetTester tester) async {
    // Build the RegisterView widget
    await tester.pumpWidget(MaterialApp(home: RegisterView()));

    // Tap on the "Sign Up" button
    await tester.tap(find.text('Sign Up'));
    await tester.pump();

    // Check if validation error messages are shown
    expect(find.text('Please enter your full name'), findsOneWidget);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter a password'), findsOneWidget);
    expect(find.text('Please confirm your password'), findsOneWidget);
  });

  testWidgets('Validates email format', (WidgetTester tester) async {
    // Build the RegisterView widget
    await tester.pumpWidget(MaterialApp(home: RegisterView()));

    // Enter an invalid email address
    await tester.enterText(find.byType(TextFormField).at(1), 'invalid-email');
    await tester.tap(find.text('Sign Up'));
    await tester.pump();

    // Check if the invalid email error is shown
    expect(find.text('Please enter a valid email address'), findsOneWidget);
  });

  testWidgets('Password visibility toggle works', (WidgetTester tester) async {
    // Build the RegisterView widget
    await tester.pumpWidget(MaterialApp(home: RegisterView()));

    // Verify that the password field is initially hidden
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);

    // Toggle the password visibility
    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();

    // Verify that the password field is now visible
    expect(find.byIcon(Icons.visibility), findsOneWidget);
  });

  testWidgets('Confirm password validation works', (WidgetTester tester) async {
    // Build the RegisterView widget
    await tester.pumpWidget(MaterialApp(home: RegisterView()));

    // Enter different passwords in the "Password" and "Confirm Password" fields
    await tester.enterText(find.byType(TextFormField).at(2), 'password123');
    await tester.enterText(
        find.byType(TextFormField).at(3), 'differentpassword123');
    await tester.tap(find.text('Sign Up'));
    await tester.pump();

    // Verify if the "Passwords do not match" error is shown
    expect(find.text('Passwords do not match'), findsOneWidget);
  });

  testWidgets('Navigates to LoginView on successful registration',
      (WidgetTester tester) async {
    // Build the RegisterView widget
    await tester.pumpWidget(MaterialApp(home: RegisterView()));

    // Enter valid values
    await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
    await tester.enterText(
        find.byType(TextFormField).at(1), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(2), 'password123');
    await tester.enterText(find.byType(TextFormField).at(3), 'password123');

    // Tap the "Sign Up" button
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();

    // Check if we are navigating to the LoginView
    expect(find.byType(LoginView), findsOneWidget);
  });

  testWidgets('Navigates to LoginView when "Sign In" is tapped',
      (WidgetTester tester) async {
    // Build the RegisterView widget
    await tester.pumpWidget(MaterialApp(home: RegisterView()));

    // Tap the "Sign In" button
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    // Verify if the LoginView is displayed
    expect(find.byType(LoginView), findsOneWidget);
  });
}

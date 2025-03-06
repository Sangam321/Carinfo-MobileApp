import 'package:carinfo/features/profile/domain/entity/user_entity.dart';
import 'package:carinfo/features/profile/domain/usecase/get_user_profile_usecase.dart';
import 'package:carinfo/features/profile/presentation/view/profile_view.dart';
import 'package:carinfo/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:carinfo/features/profile/presentation/view_model/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_view_test.mocks.dart';

@GenerateMocks([GetUserProfileUseCase])
void main() {
  late MockGetUserProfileUseCase mockGetUserProfileUseCase;
  late ProfileBloc profileBloc;

  setUp(() {
    mockGetUserProfileUseCase = MockGetUserProfileUseCase();
    profileBloc = ProfileBloc(getUserProfileUseCase: mockGetUserProfileUseCase);
  });

  tearDown(() {
    profileBloc.close();
  });

  testWidgets('displays CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(mockGetUserProfileUseCase())
        .thenAnswer((_) async => Future.delayed(Duration(seconds: 1)));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => profileBloc..add(FetchUserProfile()),
          child: ProfileView(),
        ),
      ),
    );

    // Initial state: Show loading indicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays user data when loaded', (WidgetTester tester) async {
    final user = UserEntity(
        name: 'John Doe',
        email: 'john@example.com',
        role: 'Admin',
        photoUrl: 'https://example.com/photo.jpg');

    when(mockGetUserProfileUseCase()).thenAnswer((_) async => user);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => profileBloc..add(FetchUserProfile()),
          child: ProfileView(),
        ),
      ),
    );

    // Simulate state transition
    await tester.pump();

    expect(find.text('Name: John Doe'), findsOneWidget);
    expect(find.text('Email: john@example.com'), findsOneWidget);
    expect(find.text('Role: Admin'), findsOneWidget);
  });

  testWidgets('displays error message when fetching fails',
      (WidgetTester tester) async {
    when(mockGetUserProfileUseCase())
        .thenThrow(Exception("Failed to load profile"));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => profileBloc..add(FetchUserProfile()),
          child: ProfileView(),
        ),
      ),
    );

    // Simulate state transition
    await tester.pump();

    expect(find.text("Failed to load profile"), findsOneWidget);
  });
}

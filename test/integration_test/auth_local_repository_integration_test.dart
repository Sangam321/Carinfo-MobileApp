import 'package:carinfo/core/common/internet_checker/internet_checker.dart'; // Import the InternetChecker
import 'package:carinfo/core/error/failure.dart';
import 'package:carinfo/core/network/hive_service.dart';
import 'package:carinfo/features/auth/data/data_suorce/local_data_source/auth_local_data_source.dart';
import 'package:carinfo/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:carinfo/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for InternetChecker
class MockInternetChecker extends Mock implements InternetChecker {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late AuthLocalRepository authLocalRepository;
  late AuthLocalDataSource authLocalDataSource;
  late HiveService hiveService;
  late MockInternetChecker mockInternetChecker;

  setUp(() {
    // Create a mock of InternetChecker
    mockInternetChecker = MockInternetChecker();

    // Initialize HiveService with the mock InternetChecker
    hiveService = HiveService(mockInternetChecker);
    authLocalDataSource = AuthLocalDataSource(hiveService);
    authLocalRepository = AuthLocalRepository(authLocalDataSource);
  });

  group('Integration Test for AuthLocalRepository', () {
    final testUser = AuthEntity(
        userId: '123',
        email: 'test@example.com',
        name: 'Test User',
        password: 'password123');

    test('should register and get the current user successfully', () async {
      // Register user
      await authLocalRepository.registerUser(testUser);

      // Get current user
      final result = await authLocalRepository.getCurrentUser();

      expect(result.isRight(), true);
      expect(
          result.getOrElse(
              () => AuthEntity(userId: '', name: '', email: '', password: '')),
          isA<AuthEntity>());
      expect(
          result
              .getOrElse(() =>
                  AuthEntity(userId: '', name: '', email: '', password: ''))
              .userId,
          '123');
      expect(
          result
              .getOrElse(() =>
                  AuthEntity(userId: '', name: '', email: '', password: ''))
              .name,
          'Test User');
    });

    test('should login the user successfully and return a token', () async {
      // Register the user first to simulate an existing user
      await authLocalRepository.registerUser(testUser);

      // Perform login and make sure a valid string is returned, not null
      final result = await authLocalRepository.loginUser(
          testUser.email, testUser.password);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => 'Default Value'),
          'Login successful'); // Check for valid string
    });

    test('should return LocalDatabaseFailure if registration fails', () async {
      // Simulating failure by providing invalid data (for example, passing null or incorrect values)
      final invalidUser =
          AuthEntity(userId: '', email: '', name: '', password: '');

      final result = await authLocalRepository.registerUser(invalidUser);

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<Failure>());
    });

    test('should return LocalDatabaseFailure if login fails', () async {
      // Test login failure by using invalid credentials
      final result = await authLocalRepository.loginUser(
          'invalid@example.com', 'wrongpassword');

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<Failure>());
    });
  });
}

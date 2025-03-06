import 'package:carinfo/app/shared_prefs/token_shared_prefs.dart';
import 'package:carinfo/core/network/api_service.dart';
import 'package:carinfo/core/network/hive_service.dart';
import 'package:carinfo/features/auth/data/data_suorce/local_data_source/auth_local_data_source.dart';
import 'package:carinfo/features/auth/data/data_suorce/remote_data_source/auth_remote_data_source.dart';
import 'package:carinfo/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:carinfo/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:carinfo/features/auth/domain/use_case/login_usecase.dart';
import 'package:carinfo/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:carinfo/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:carinfo/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:carinfo/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:carinfo/features/boarding_page/presentation/view_model/boarding_cubit.dart';
import 'package:carinfo/features/home/presentation/view_model/home_cubit.dart';
import 'package:carinfo/features/splash/view_model/splash_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize necessary services
  _initHiveService();
  _initApiService();
  await _initSharedPreferences();

  _initHomeDependencies();
  _initRegisterDependencies();
  _initLoginDependencies();
  _initSplashScreenDependencies();
  _initBoardingDependencies(); // ✅ Added missing registration for BoardingCubit
}

// Initialize Shared Preferences
Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

// Initialize API Service
void _initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

// Initialize Hive Service
void _initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

// Initialize Registration Dependencies
void _initRegisterDependencies() {
  // =========================== Data Source ===========================
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // =========================== Repository ===========================
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // =========================== Use Cases ===========================
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  // =========================== Blocs ===========================
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

// Initialize Home Dependencies
void _initHomeDependencies() {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

// Initialize Login Dependencies
void _initLoginDependencies() {
  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  // =========================== Use Cases ===========================
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  // =========================== Blocs ===========================
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

// Initialize Splash Screen Dependencies
void _initSplashScreenDependencies() {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}

// ✅ Initialize Boarding Page Dependencies
void _initBoardingDependencies() {
  getIt.registerFactory<BoardingCubit>(
    () => BoardingCubit(),
  );
}

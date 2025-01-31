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
import 'package:carinfo/features/splash/view_model/splash_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initSplashDependencies();
  await _initOnboardingDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initSplashDependencies() {
  getIt.registerFactory<SplashCubit>(() => SplashCubit());
}

_initOnboardingDependencies() {
  getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit());
}

class OnboardingCubit {}

_initRegisterDependencies() {
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

  // =========================== Usecases ===========================
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

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

_initLoginDependencies() async {
  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthLocalRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

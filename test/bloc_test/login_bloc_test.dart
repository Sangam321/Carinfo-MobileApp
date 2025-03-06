import 'package:bloc_test/bloc_test.dart';
import 'package:carinfo/features/auth/domain/use_case/login_usecase.dart';
import 'package:carinfo/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:carinfo/features/home/presentation/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

// Mocks
class MockRegisterBloc extends Mock implements RegisterBloc {}

class MockHomeCubit extends Mock implements HomeCubit {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late LoginBloc loginBloc;
  late MockRegisterBloc mockRegisterBloc;
  late MockHomeCubit mockHomeCubit;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();
    mockHomeCubit = MockHomeCubit();
    mockLoginUseCase = MockLoginUseCase();
    loginBloc = LoginBloc(
      registerBloc: mockRegisterBloc,
      homeCubit: mockHomeCubit,
      loginUseCase: mockLoginUseCase,
    );
  });

  group('LoginBloc', () {
    test('initial state is correct', () {
      expect(loginBloc.state, LoginState.initial());
    });

    blocTest<LoginBloc, LoginState>(
      'emits [isLoading: true, isSuccess: false] when LoginUserEvent is added and login fails',
      build: () {
        when(mockLoginUseCase(any)).thenAnswer((_) async => Left(Failure()));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginUserEvent(
          email: 'test@test.com',
          password: 'password',
          context: BuildContext())),
      expect: () => [
        LoginState(isLoading: true),
        LoginState(isLoading: false, isSuccess: false),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [isLoading: true, isSuccess: true] when LoginUserEvent is added and login is successful',
      build: () {
        when(mockLoginUseCase(any)).thenAnswer((_) async => Right('fakeToken'));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginUserEvent(
          email: 'test@test.com',
          password: 'password',
          context: BuildContext())),
      expect: () => [
        LoginState(isLoading: true),
        LoginState(isLoading: false, isSuccess: true),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits correct navigation state on NavigateHomeScreenEvent',
      build: () {
        return loginBloc;
      },
      act: (bloc) => bloc.add(NavigateHomeScreenEvent(
        context: BuildContext(),
        destination: Container(),
      )),
      verify: (_) {
        verify(loginBloc.add(NavigateHomeScreenEvent(
          context: BuildContext(),
          destination: Container(),
        )));
      },
    );
  });
}

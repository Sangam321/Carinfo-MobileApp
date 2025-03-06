import 'package:carinfo/app/di/di.dart';
import 'package:carinfo/features/auth/presentation/view/login_view.dart';
import 'package:carinfo/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:carinfo/features/home/presentation/view_model/home_state.dart';
import 'package:carinfo/features/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void onTabTapped(int index, BuildContext context) {
    if (index == 3) {
      // Assuming Profile is at index 3
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileView()),
      );
    }
    emit(state.copyWith(selectedIndex: index));
  }

  void logout(BuildContext context) {
    // Wait for 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<LoginBloc>(),
              child: LoginView(),
            ),
          ),
        );
      }
    });
  }
}

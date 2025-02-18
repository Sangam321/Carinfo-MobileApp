import 'package:carinfo/features/auth/presentation/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardingCubit extends Cubit<int> {
  final PageController pageController = PageController();

  BoardingCubit() : super(0);

  // List of onboarding data
  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/logo.png',
      'text': 'Discover Every Detail, Drive Every Dream',
    },
    {
      'image': 'assets/images/logo.png',
      'text': 'Find Your Perfect Car with Ease',
    },
    {
      'image': 'assets/images/logo.png',
      'text': 'Compare and Choose the Best',
    },
    {
      'image': 'assets/images/logo.png',
      'text': 'Drive Your Dreams Today!',
    },
  ];

  // Go to the next page
  void goToNextPage() {
    if (state < pages.length - 1) {
      emit(state + 1);
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Skip to the last page
  void skipToLastPage() {
    emit(pages.length - 1);
    pageController.jumpToPage(pages.length - 1);
  }

  // Navigate to the login screen
  void navigateToAuthScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}

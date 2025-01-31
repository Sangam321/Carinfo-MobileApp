import 'package:carinfo/features/boarding_page/presentation/view_model/boarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardingView extends StatelessWidget {
  const BoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BoardingCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<BoardingCubit, int>(
          builder: (context, state) {
            final cubit = context.read<BoardingCubit>();
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: cubit.pageController,
                    onPageChanged: (index) {
                      cubit.emit(index);
                    },
                    itemCount: cubit.pages.length,
                    itemBuilder: (context, index) {
                      final page = cubit.pages[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            page['image']!,
                            height: 190.0,
                            width: 190.0,
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            'Carinfo',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF390050),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            page['text']!,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 130, 129, 129),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    cubit.pages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      height: 8.0,
                      width: state == index ? 16.0 : 8.0,
                      decoration: BoxDecoration(
                        color: state == index
                            ? const Color(0xFF390050)
                            : const Color(0xFFD8D8D8),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          cubit.navigateToAuthScreen(context);
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFF390050),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (state == cubit.pages.length - 1) {
                            cubit.navigateToAuthScreen(context);
                          } else {
                            cubit.goToNextPage();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: const Color(0xFF390050),
                        ),
                        child: Text(
                          state == cubit.pages.length - 1 ? 'Finish' : 'Next',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

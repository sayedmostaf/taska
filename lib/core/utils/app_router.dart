import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/features/auth/presentation/view/auth_view.dart';
import 'package:taska/features/home/presentation/view/create_category_view.dart';
import 'package:taska/features/home/presentation/view/home_view.dart';
import 'package:taska/features/on_boarding/presentation/view/on_boarding_view.dart';
import 'package:taska/features/splash/presentation/view/splash_view.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kOnboardingView = '/onboarding';
  static const kAuthView = '/auth';
  static const kHomeView = '/home';
  static const kCreateCategoryView = '/create_category';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnboardingView,
        pageBuilder: (context, state) =>
            screenTransition(state, const OnBoardingView()),
      ),
      GoRoute(
        path: kAuthView,
        pageBuilder: (context, state) =>
            screenTransition(state, const AuthView()),
      ),
      GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) =>
            screenTransition(state, const HomeView()),
      ),
      GoRoute(
        path: kCreateCategoryView,
        pageBuilder: (context, state) =>
            screenTransition(state, const CreateCategoryView()),
      ),
    ],
  );
}

CustomTransitionPage<void> screenTransition(
  GoRouterState state,
  Widget screen,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: screen,
    transitionDuration: Duration(milliseconds: 300),
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          );
        },
  );
}

import 'package:go_router/go_router.dart';
import 'package:taska/features/on_boarding/presentation/view/on_boarding_view.dart';
import 'package:taska/features/splash/presentation/view/splash_view.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kOnboardingView = '/onboarding';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnboardingView,
        builder: (context, state) => const OnBoardingView(),
      ),
    ],
  );
}

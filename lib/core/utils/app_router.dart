import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/service_locator.dart';
import 'package:taska/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:taska/features/auth/domain/usecases/log_in_user_with_email_and_password_use_case.dart';
import 'package:taska/features/auth/domain/usecases/log_in_user_with_google_use_case.dart';
import 'package:taska/features/auth/domain/usecases/register_user_with_email_and_password_use_case.dart';
import 'package:taska/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:taska/features/auth/domain/usecases/verify_email_use_case.dart';
import 'package:taska/features/auth/presentation/manager/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:taska/features/auth/presentation/manager/log_in_user_with_google_cubit/log_in_user_with_google_cubit.dart';
import 'package:taska/features/auth/presentation/manager/login_user_with_email_and_password_cubit/login_user_with_email_and_password_cubit.dart';
import 'package:taska/features/auth/presentation/manager/register_user_with_email_and_password/register_user_with_email_and_password_cubit.dart';
import 'package:taska/features/auth/presentation/manager/sign_out_cubit/sign_out_cubit.dart';
import 'package:taska/features/auth/presentation/manager/verify_email_cubit/verify_email_cubit.dart';
import 'package:taska/features/auth/presentation/view/auth_view/auth_view.dart';
import 'package:taska/features/auth/presentation/view/email_verify_view/email_verify_view.dart';
import 'package:taska/features/auth/presentation/view/forgot_password_view/forgot_password_view.dart';
import 'package:taska/features/home/domain/entities/task.dart';
import 'package:taska/features/home/domain/usecases/create_category_use_case.dart';
import 'package:taska/features/home/domain/usecases/create_task_use_case.dart';
import 'package:taska/features/home/presentation/manager/create_category_cubit/create_category_cubit.dart';
import 'package:taska/features/home/presentation/manager/create_task_cubit/create_task_cubit.dart';
import 'package:taska/features/home/presentation/manager/get_categories_cubit/get_categories_cubit.dart';
import 'package:taska/features/home/presentation/view/create_category_view/create_category_view.dart';
import 'package:taska/features/home/presentation/view/home_view/home_view.dart';
import 'package:taska/features/index/domain/usecases/delete_task_usecase.dart';
import 'package:taska/features/index/domain/usecases/edit_task_usecase.dart';
import 'package:taska/features/index/domain/usecases/get_task_by_day_use_case.dart';
import 'package:taska/features/index/presentation/manager/delete_task_cubit/delete_task_cubit.dart';
import 'package:taska/features/index/presentation/manager/edit_task_cubit/edit_task_cubit.dart';
import 'package:taska/features/index/presentation/manager/get_task_by_day_cubit/get_task_by_day_cubit.dart';
import 'package:taska/features/index/presentation/view/edit_task_view/edit_task_view.dart';
import 'package:taska/features/on_boarding/presentation/view/on_boarding_view.dart';
import 'package:taska/features/profile/presentation/view/settings_view/settings_view.dart';
import 'package:taska/features/splash/presentation/view/splash_view.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kOnboardingView = '/onboarding';
  static const kAuthView = '/auth';
  static const kHomeView = '/home';
  static const kCreateCategoryView = '/create_category';
  static const kEditTaskView = '/edit_task';
  static const kSettingsView = '/settings';
  static const kForgetPasswordView = '/forget_password';
  static const kEmailVerifyView = '/email_verify';

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
        pageBuilder: (context, state) => screenTransition(
          state,
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => RegisterUserWithEmailAndPasswordCubit(
                  getIt.get<RegisterUserWithEmailAndPasswordUseCase>(),
                ),
              ),
              BlocProvider(
                create: (context) => LoginUserWithEmailAndPasswordCubit(
                  getIt.get<LogInUserWithEmailAndPasswordUseCase>(),
                ),
              ),
              BlocProvider(
                create: (context) => LogInUserWithGoogleCubit(
                  getIt.get<LogInUserWithGoogleUseCase>(),
                ),
              ),
            ],
            child: AuthView(),
          ),
        ),
      ),
      GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) => screenTransition(
          state,
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    CreateTaskCubit(getIt.get<CreateTaskUseCase>()),
              ),
              BlocProvider(
                create: (context) =>
                    GetTasksByDayCubit(getIt.get<GetTaskByDayUseCase>())
                      ..getTaskByDay(
                        DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          0,
                          0,
                          0,
                        ),
                      ),
              ),
            ],
            child: const HomeView(),
          ),
        ),
      ),
      GoRoute(
        path: kCreateCategoryView,
        pageBuilder: (context, state) {
          GetCategoriesCubit cubit = state.extra as GetCategoriesCubit;
          return screenTransition(
            state,
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => CreateCategoryCubit(
                    createCategoryUseCase: getIt.get<CreateCategoryUseCase>(),
                  ),
                ),
                BlocProvider.value(value: cubit),
              ],
              child: const CreateCategoryView(),
            ),
          );
        },
      ),
      GoRoute(
        path: kEditTaskView,
        pageBuilder: (context, state) {
          (TaskEntity, GetTasksByDayCubit) model =
              state.extra as (TaskEntity, GetTasksByDayCubit);
          return screenTransition(
            state,
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      EditTaskCubit(getIt.get<EditTaskUseCase>()),
                ),
                BlocProvider(
                  create: (context) =>
                      DeleteTaskCubit(getIt.get<DeleteTaskUseCase>()),
                ),
                BlocProvider.value(value: model.$2),
              ],
              child: EditTaskView(task: model.$1),
            ),
          );
        },
      ),
      GoRoute(
        path: kSettingsView,
        pageBuilder: (context, state) =>
            screenTransition(state, const SettingsView()),
      ),
      GoRoute(
        path: kForgetPasswordView,
        pageBuilder: (context, state) => screenTransition(
          state,
          BlocProvider(
            create: (context) =>
                ForgotPasswordCubit(getIt.get<ForgetPasswordUseCase>()),
            child: const ForgotPasswordView(),
          ),
        ),
      ),
      GoRoute(
        path: kEmailVerifyView,
        pageBuilder: (context, state) => screenTransition(
          state,
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    VerifyEmailCubit(getIt.get<VerifyEmailUseCase>()),
              ),
              BlocProvider(
                create: (context) => SignOutCubit(getIt.get<SignOutUseCase>()),
              ),
            ],
            child: const EmailVerifyView(),
          ),
        ),
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

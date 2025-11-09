import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/core/utils/service_locator.dart';
import 'package:taska/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:taska/features/profile/presentation/manager/delete_account_cubit/delete_account_cubit.dart';
import 'package:taska/features/profile/presentation/view/profile_view/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DeleteAccountCubit(getIt.get<DeleteAccountUseCase>()),
      child: ProfileViewBody(),
    );
  }
}

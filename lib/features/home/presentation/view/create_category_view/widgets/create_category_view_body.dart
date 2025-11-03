import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_loading_animation.dart';
import 'package:taska/core/widgets/custom_sliver_sized_box.dart';
import 'package:taska/features/home/domain/entities/category.dart';
import 'package:taska/features/home/presentation/manager/create_category_cubit/create_category_cubit.dart';
import 'package:taska/features/home/presentation/manager/create_category_cubit/create_category_state.dart';
import 'package:taska/features/home/presentation/manager/get_categories_cubit/get_categories_cubit.dart';
import 'package:taska/features/home/presentation/view/create_category_view/widgets/category_color_section.dart';
import 'package:taska/features/home/presentation/view/create_category_view/widgets/category_icon_section.dart';
import 'package:taska/features/home/presentation/view/create_category_view/widgets/category_name_section.dart';
import 'package:taska/features/home/presentation/view/create_category_view/widgets/create_category_action_buttons.dart';
import 'package:taska/features/home/presentation/view/create_category_view/widgets/create_category_back_arrow.dart';
import 'package:uuid/uuid.dart';

class CreateCategoryViewBody extends StatefulWidget {
  const CreateCategoryViewBody({super.key});

  @override
  State<CreateCategoryViewBody> createState() => _CreateCategoryViewBodyState();
}

class _CreateCategoryViewBodyState extends State<CreateCategoryViewBody> {
  final GlobalKey<FormFieldState<String>> categoryNameKey =
      GlobalKey<FormFieldState<String>>();
  late String name;
  late int? iconCode;
  late String? colorHex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomSliverSizedBox(height: 50.h),
          SliverToBoxAdapter(child: CreateCategoryBackArrow()),
          CustomSliverSizedBox(height: 20.h),
          SliverToBoxAdapter(
            child: Text(
              StringsManager.createNew.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          CustomSliverSizedBox(height: 20.h),
          SliverToBoxAdapter(
            child: CategoryNameSection(
              categoryNameKey: categoryNameKey,
              onSaved: (p0) {
                name = p0!;
              },
            ),
          ),
          SliverToBoxAdapter(
            child: CategoryIconSection(
              onChanged: (code) {
                iconCode = code;
              },
            ),
          ),
          SliverToBoxAdapter(
            child: CategoryColorSection(
              onChanged: (color) {
                colorHex = color;
              },
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: BlocListener<CreateCategoryCubit, CreateCategoryState>(
              listener: (context, state) {
                if (state is CreateCategoryLoading) {
                  CustomLoadingAnimation.buildLoadingIndicator(context);
                } else if (state is CreateCategoryFailure) {
                  GoRouter.of(context).pop();
                  Fluttertoast.showToast(
                    msg: state.errMessage,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                } else if (state is CreateCategorySuccess) {
                  GoRouter.of(context).pop();
                  GoRouter.of(context).pop();
                  BlocProvider.of<GetCategoriesCubit>(
                    context,
                  ).getAllCategories();
                  Fluttertoast.showToast(
                    msg: StringsManager.categoryCreatedSuccessfully.tr(),
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }
              },
              child: CreateCategoryActionButtons(
                onPressed: () {
                  if (iconCode == null) {
                    Fluttertoast.showToast(
                      msg: StringsManager.pleaseChooseAnIcon,
                    );
                    return;
                  }
                  if (colorHex == null) {
                    Fluttertoast.showToast(
                      msg: StringsManager.pleasePickAColor,
                    );
                    return;
                  }
                  if (categoryNameKey.currentState!.validate() &&
                      iconCode != null &&
                      colorHex != null) {
                    categoryNameKey.currentState!.save();

                    BlocProvider.of<CreateCategoryCubit>(
                      context,
                    ).createCategory(
                      CategoryEntity(
                        id: Uuid().v4(),
                        name: name,
                        iconData: iconCode!,
                        color: colorHex!,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

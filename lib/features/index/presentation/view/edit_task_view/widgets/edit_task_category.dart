import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taska/core/utils/assets_manager.dart';
import 'package:taska/core/utils/functions/extensions.dart';
import 'package:taska/core/utils/service_locator.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_clickable_container.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:taska/core/widgets/custom_loading_animation.dart';
import 'package:taska/core/widgets/save_cancel_action_buttons.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/features/home/domain/entities/category.dart';
import 'package:taska/features/home/domain/usecases/delete_category_use_case.dart';
import 'package:taska/features/home/domain/usecases/get_all_categories_use_case.dart';
import 'package:taska/features/home/presentation/manager/delete_category_cubit.dart/delete_category_cubit.dart';
import 'package:taska/features/home/presentation/manager/get_categories_cubit/get_categories_cubit.dart';
import 'package:taska/features/home/presentation/manager/get_categories_cubit/get_categories_state.dart';
import 'package:taska/features/home/presentation/view/home_view/widgets/add_category_button.dart';
import 'package:taska/features/home/presentation/view/home_view/widgets/task_category_item.dart';

class EditTaskCategory extends StatefulWidget {
  const EditTaskCategory({
    super.key,
    required this.categoryEntity,
    required this.onSavedCategory,
  });
  final CategoryEntity categoryEntity;
  final Function(CategoryEntity) onSavedCategory;

  @override
  State<EditTaskCategory> createState() => _EditTaskCategoryState();
}

class _EditTaskCategoryState extends State<EditTaskCategory> {
  late String id, categoryName;
  late int iconData;
  late String color;
  int? selectedCategoryIndex;
  @override
  void initState() {
    super.initState();
    id = widget.categoryEntity.id;
    categoryName = widget.categoryEntity.name;
    iconData = widget.categoryEntity.iconData;
    color = widget.categoryEntity.color;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(CustomIcons.tag_icon),
        SizedBox(width: 8.w),
        Text(
          StringsManager.taskCategory.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Spacer(),
        CustomClickableContainer(
          text: categoryName,
          icon: Icon(iconData.toIconData(), size: 15.sp),
          onTap: () {
            buildChooseCategoryDialog(context);
          },
        ),
      ],
    );
  }

  void buildChooseCategoryDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) {
        return BlocProvider(
          create: (context) =>
              GetCategoriesCubit(getIt.get<GetAllCategoriesUseCase>())
                ..getAllCategories(),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            elevation: 8,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                final isDark = Theme.of(context).brightness == Brightness.dark;
                return Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 18.h,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? ColorManager.surfaceColorDark
                              : ColorManager.surfaceColorLight,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: ColorManager.primaryColor.withOpacity(
                                  0.1,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                CustomIcons.tag_icon,
                                color: ColorManager.primaryColor,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                StringsManager.chooseCategory.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1, thickness: 1),
                      // Content
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: _buildChooseCategoryGridView(setState),
                        ),
                      ),
                      // Actions
                      Divider(height: 1, thickness: 1),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 16.h,
                        ),
                        child: SaveCancelActionButtons(
                          cancelOnPressed: () {
                            selectedCategoryIndex = null;
                            id = widget.categoryEntity.id;
                            color = widget.categoryEntity.color;
                            iconData = widget.categoryEntity.iconData;
                            categoryName = widget.categoryEntity.name;
                            widget.onSavedCategory(
                              CategoryEntity(
                                id: id,
                                name: categoryName,
                                iconData: iconData,
                                color: color,
                              ),
                            );
                            GoRouter.of(context).pop();
                          },
                          saveOnPressed: () {
                            widget.onSavedCategory(
                              CategoryEntity(
                                id: id,
                                name: categoryName,
                                iconData: iconData,
                                color: color,
                              ),
                            );
                            GoRouter.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
    setState(() {});
  }

  Widget _buildChooseCategoryGridView(StateSetter setState) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
            builder: (context, state) {
              if (state is GetCategoriesLoading) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CustomCircularIndicator()),
                );
              } else if (state is GetCategoriesFailure) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          AssetsManager.error,
                          width: 150.w,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        StringsManager.operationNotAllowed.tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                );
              } else if (state is GetCategoriesSuccess) {
                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 20.h,
                  ),
                  delegate: SliverChildBuilderDelegate((
                    BuildContext context,
                    int index,
                  ) {
                    if (index < state.categories.length) {
                      return BlocProvider(
                        create: (context) => DeleteCategoryCubit(
                          getIt.get<DeleteCategoryUseCase>(),
                        ),
                        child: TaskCategoryItem(
                          category: state.categories[index],
                          selected: selectedCategoryIndex == index,
                          onTap: () {
                            setState(() {
                              selectedCategoryIndex = index;
                              id = state.categories[index].id;
                              color = state.categories[index].color;
                              iconData = state.categories[index].iconData;
                              categoryName = state.categories[index].name;
                            });
                          },
                        ),
                      );
                    } else {
                      return AddCategoryButton(
                        getCategoriesCubit: BlocProvider.of<GetCategoriesCubit>(
                          context,
                        ),
                      );
                    }
                  }, childCount: state.categories.length + 1),
                );
              }
              return const SliverToBoxAdapter();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/di/injection.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/core/utils/network_image_util.dart';
import 'package:todoapp/core/utils/string_to_color.dart';
import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/presentation/cubit/dialog/category_cubit.dart';
import 'package:todoapp/presentation/cubit/dialog/category_state.dart';
import 'package:todoapp/presentation/widget/button/button_submit.dart';

class ChooseCategoryDialog extends StatelessWidget {
  final Category? initialCategory;
  const ChooseCategoryDialog({super.key, this.initialCategory});

  static Future<Category?> show(
    BuildContext context, {
    Category? initialCategory,
  }) {
    return showDialog<Category?>(
      context: context,
      builder: (context) =>
          ChooseCategoryDialog(initialCategory: initialCategory),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryCubit>(
      create: (context) => getIt<CategoryCubit>()..getCategories(),
      child: _ChooseCategoryDialogView(),
    );
  }
}

class _ChooseCategoryDialogView extends StatelessWidget {
  const _ChooseCategoryDialogView();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return Dialog(
          backgroundColor: AppColors.bottomAppBar,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsGeometry.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Choose Category',
                    style: AppTextStyle.titleSmallBold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Container(height: 1, color: AppColors.divier),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: state.categories.length + 1,
                    itemBuilder: (context, index) =>
                        index != state.categories.length
                        ? CategoryItem(
                            onTap: () {
                              context.read<CategoryCubit>().onSelectCategory(
                                state.categories[index],
                              );
                            },
                            category: state.categories[index],
                            isSelected:
                                state.selectedCategory?.id ==
                                state.categories[index].id,
                          )
                        : AddCategoryItem(),
                  ),
                  const SizedBox(height: 32),
                  _buildChooseCategoryAction(context, state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChooseCategoryAction(BuildContext context, CategoryState state) {
    return Row(
      children: [
        Expanded(
          child: ButtonSubmit(
            text: 'Cancel',
            textActiveColor: AppColors.primary,
            activeBackgroundColor: AppColors.transparent,
            onSubmit: () {
              context.pop();
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ButtonSubmit(
            onSubmit: () {
              context.pop(state.selectedCategory);
            },
            text: 'Save',
            textActiveColor: AppColors.textPrimary,
            activeBackgroundColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isSelected;
  final Category category;

  const CategoryItem({
    this.onTap,
    this.isSelected = false,
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform.scale(
        scale: isSelected ? 1.12 : 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: category.color.toColor(),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: NetworkImageUtil.load(
                  category.icon,
                  width: 32,
                  height: 32,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(category.name, style: AppTextStyle.labelMedium),
          ],
        ),
      ),
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:todoapp/domain/entities/category.dart';

enum CategoryError { initial, loadding, success, failure }

class CategoryState extends Equatable {
  final CategoryError status;
  final Category? initial;
  final List<Category> categories;
  final Category? selectedCategory;

  const CategoryState({
    this.status = CategoryError.initial,
    this.initial,
    this.categories = const [],
    this.selectedCategory,
  });

  @override
  List<Object?> get props => [status, selectedCategory, categories];

  CategoryState copyWith({
    CategoryError? status,
    Category? initial,
    Category? selectedCategory,
    List<Category>? categories,
  }) {
    return CategoryState(
      status: status ?? this.status,
      initial: initial ?? this.initial,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categories: categories ?? this.categories,
    );
  }
}

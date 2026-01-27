import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/domain/usecase/get_categories_usecase.dart';
import 'package:todoapp/presentation/cubit/dialog/category_state.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  StreamSubscription? _subscription;

  CategoryCubit(this._getCategoriesUseCase) : super(const CategoryState());

  void getCategories() {
    emit(state.copyWith(status: CategoryError.loadding));

    _subscription = _getCategoriesUseCase.execute().listen((either) {
      either.fold(
        (failure) {
          emit(state.copyWith(status: CategoryError.failure));
        },
        (categories) {
          emit(
            state.copyWith(
              status: CategoryError.success,
              categories: categories,
            ),
          );
        },
      );
    });
  }

  void onSelectCategory(Category? category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void initialCategory(Category? initicalCategory) {
    emit(state.copyWith(initial: initicalCategory));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

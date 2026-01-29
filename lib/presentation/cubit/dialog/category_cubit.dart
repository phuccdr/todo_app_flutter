import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/domain/usecase/fetch_categories_usecase.dart';
import 'package:todoapp/domain/usecase/watch_categories_usecase.dart';
import 'package:todoapp/presentation/cubit/dialog/category_state.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  final FetchCategoriesUseCase _fetchCategoriesUseCase;
  final WatchCategoriesUsecase _watchCategoriesUsecase;
  StreamSubscription? _subscription;

  CategoryCubit(this._fetchCategoriesUseCase, this._watchCategoriesUsecase)
    : super(const CategoryState());

  void initial() {
    _subscription = _watchCategoriesUsecase.execute().listen(
      (either) => either.fold(
        (failure) => emit(state.copyWith(status: CategoryError.failure)),
        (categories) => emit(
          state.copyWith(categories: categories, status: CategoryError.success),
        ),
      ),
    );
  }

  void fetchCategories() async {
    emit(state.copyWith(status: CategoryError.loadding));
    final result = await _fetchCategoriesUseCase.execute();
    result.fold(
      (failure) => emit(state.copyWith(status: CategoryError.initial)),
      (_) {},
    );
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

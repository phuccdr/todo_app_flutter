import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:todoapp/core/utils/validator/not_null_validator.dart';
import 'package:todoapp/core/utils/validator/text_input_validator.dart';
import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/domain/entities/priority.dart';
import 'package:todoapp/domain/entities/task.dart';

class AddTaskState extends Equatable {
  final TextInputValidator titleValidator;
  final TextInputValidator descriptionValidator;
  final NotNullValidator<DateTime> timeTaskValidator;
  final NotNullValidator<Priority> priorityValidator;
  final NotNullValidator<Category> categoryValidator;
  final bool isValid;
  final FormzSubmissionStatus status;
  final Task? initial;

  const AddTaskState({
    this.status = FormzSubmissionStatus.initial,
    this.titleValidator = const TextInputValidator.pure(),
    this.descriptionValidator = const TextInputValidator.pure(),
    this.timeTaskValidator = const NotNullValidator.pure(),
    this.priorityValidator = const NotNullValidator.pure(),
    this.categoryValidator = const NotNullValidator.pure(),
    this.isValid = false,
    this.initial,
  });
  @override
  List<Object?> get props => [
    status,
    titleValidator,
    descriptionValidator,
    timeTaskValidator,
    priorityValidator,
    categoryValidator,
    status,
    isValid,
    initial,
  ];

  AddTaskState copyWith({
    FormzSubmissionStatus? status,
    TextInputValidator? titleValidator,
    TextInputValidator? descriptionValidator,
    NotNullValidator<DateTime>? timeTaskValidator,
    NotNullValidator<Priority>? priorityValidator,
    NotNullValidator<Category>? categoryValidator,
    bool? isValid,
    Task? initial,
  }) {
    final newTitle = titleValidator ?? this.titleValidator;
    final newDescription = descriptionValidator ?? this.descriptionValidator;
    final newTimeTask = timeTaskValidator ?? this.timeTaskValidator;
    final newPriority = priorityValidator ?? this.priorityValidator;
    final newCategory = categoryValidator ?? this.categoryValidator;

    final isValid = Formz.validate([
      newTitle,
      newDescription,
      newTimeTask,
      newPriority,
      newCategory,
    ]);

    return AddTaskState(
      status: status ?? this.status,
      titleValidator: newTitle,
      descriptionValidator: newDescription,
      timeTaskValidator: newTimeTask,
      priorityValidator: newPriority,
      categoryValidator: newCategory,
      isValid: isValid,
      initial: initial,
    );
  }
}

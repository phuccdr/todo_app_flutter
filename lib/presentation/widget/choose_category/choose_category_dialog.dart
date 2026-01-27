import 'package:flutter/material.dart';
import 'package:todoapp/domain/entities/category.dart';

class ChooseCategoryDialog extends StatefulWidget {
  final Category? initialCategory;
  const ChooseCategoryDialog({super.key, this.initialCategory});
  @override
  State<StatefulWidget> createState() {
    return _ChooseCategoryDialogState();
  }
}

class _ChooseCategoryDialogState extends State<ChooseCategoryDialog> {
  late Category _selectCategory;
  @override
  void initState() {
    super.initState();
    _selectCategory = widget.initialCategory ?? Category();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

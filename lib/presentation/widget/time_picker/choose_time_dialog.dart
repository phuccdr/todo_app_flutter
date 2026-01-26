import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';

class ChooseTimeDialog extends StatefulWidget {
  final DateTime? intialDate;
  const ChooseTimeDialog({super.key, this.intialDate});

  @override
  State<StatefulWidget> createState() {
    return _ChooseTimeDialogState();
  }
}

class _ChooseTimeDialogState extends State<ChooseTimeDialog> {
  late DateTime _selectTime;
  late int selectHour;
  late int selectMinute;
  late bool isAm;
  late FixedExtentScrollController controllerHour;
  final int loopCount = 100;
  final int hourCount = 12;

  @override
  void initState() {
    super.initState();
    _selectTime = widget.intialDate ?? DateTime.now();
    if (_selectTime.hour >= 12) {
      isAm = false;
      selectHour = _selectTime.hour - 12;
    } else {
      isAm = true;
      selectHour = _selectTime.hour;
    }
    selectMinute = _selectTime.minute;
    controllerHour = FixedExtentScrollController(initialItem: selectHour);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.bottomAppBar,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsetsGeometry.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choose Time', style: AppTextStyle.body),
            Container(color: AppColors.divier, height: 1),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CupertinoPicker(
                    itemExtent: 40,
                    scrollController: controllerHour,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectHour = index % hourCount;
                      });
                    },
                    children: List.generate(hourCount * loopCount, (index) {
                      final hour = index % hourCount;
                      return Center(
                        child: Text(
                          hour.toString().padLeft(2, '0'),
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

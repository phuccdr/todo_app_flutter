import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/presentation/widget/time_picker/choose_time_dialog.dart';

class CustomTimePickerDialog extends StatefulWidget {
  final DateTime? intialDate;
  const CustomTimePickerDialog({super.key, this.intialDate});
  @override
  State<StatefulWidget> createState() {
    return _CustomTimePickerDialogState();
  }
}

class _CustomTimePickerDialogState extends State<CustomTimePickerDialog> {
  late DateTime _selectDate;
  late DateTime _focusMonth;

  @override
  void initState() {
    super.initState();
    _selectDate = widget.intialDate ?? DateTime.now();
    _focusMonth = DateTime(_selectDate.year, _selectDate.month);
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
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            Container(height: 1, color: AppColors.divier),
            const SizedBox(height: 8),
            _buildCalender(),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: AppTextStyle.body.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ChooseTimeDialog(
                            intialDate: widget.intialDate,
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.primary,
                      ),
                      child: Center(
                        child: Text('Choose Time', style: AppTextStyle.body),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          padding: const EdgeInsets.all(5),
          onPressed: () {
            setState(() {
              _focusMonth = DateTime(
                _focusMonth.year,
                _focusMonth.month - 1,
                _focusMonth.day,
              );
            });
          },
          icon: Icon(Icons.arrow_back_ios, size: 16, color: AppColors.white),
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _getMonthName(_focusMonth.month),
              style: AppTextStyle.titleSmall.copyWith(fontSize: 14),
            ),
            Text(
              _focusMonth.year.toString(),
              style: AppTextStyle.labelSmall.copyWith(
                color: AppColors.textGray,
              ),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          padding: const EdgeInsets.all(5),
          onPressed: () {
            setState(() {
              _focusMonth = DateTime(
                _focusMonth.year,
                _focusMonth.month + 1,
                _focusMonth.day,
              );
            });
          },
          icon: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.white),
        ),
      ],
    );
  }

  Widget _buildCalender() {
    const days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    final daysInMonth = _getDaysInMonth(_focusMonth);
    final firstWeekDay =
        DateTime(_focusMonth.year, _focusMonth.month, 1).weekday % 7;
    final previousMonth = DateTime(_focusMonth.year, _focusMonth.month, 0);
    final daysInPreviousMonth = _getDaysInMonth(previousMonth);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
        mainAxisSpacing: 12,
        crossAxisSpacing: 24,
      ),
      itemCount: 42,
      itemBuilder: (context, index) {
        if (index < 7) {
          return Text(
            days[index],
            style: AppTextStyle.labelSmall.copyWith(
              color: index == 0 || index == 6
                  ? AppColors.red
                  : AppColors.textPrimary,
            ),
          );
        } else {
          index = index - 7;
        }
        // Tinh ngay trong thang tu index va thu dau trong thang
        int dayNumber = index - firstWeekDay + 1; //0-2+1=-1
        bool isCurrentMonth = true;
        int month = _focusMonth.month;
        if (dayNumber < 1) {
          dayNumber = daysInPreviousMonth + dayNumber;
          isCurrentMonth = false;
          month--;
        } else if (dayNumber > daysInMonth) {
          dayNumber = dayNumber - daysInMonth;
          month++;
          isCurrentMonth = false;
        }
        final date = DateTime(_focusMonth.year, month, dayNumber);
        final isSelected = _isSameDay(date, _selectDate);

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectDate = date;
              if (!isCurrentMonth) {
                _focusMonth = date;
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: isCurrentMonth
                  ? (isSelected ? AppColors.primary : AppColors.card)
                  : AppColors.transparent,
            ),
            child: Center(
              child: Text(
                dayNumber.toString(),
                style: AppTextStyle.bodySmallBold,
              ),
            ),
          ),
        );
      },
    );
  }

  int _getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

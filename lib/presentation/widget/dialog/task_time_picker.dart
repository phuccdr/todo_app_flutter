import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/presentation/widget/button/button_submit.dart';

class TaskTimePicker extends StatefulWidget {
  final DateTime? intialDate;

  const TaskTimePicker({super.key, this.intialDate});

  /// Hiển thị TaskTimePicker dưới dạng Dialog
  static Future<DateTime?> show(BuildContext context, {DateTime? initialDate}) {
    return showDialog<DateTime>(
      context: context,
      builder: (context) => TaskTimePicker(intialDate: initialDate),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return TaskTimePickerState();
  }
}

class TaskTimePickerState extends State<TaskTimePicker> {
  late DateTime _selectDate;
  late DateTime _focusMonth;
  late FixedExtentScrollController _controllerHour;
  late FixedExtentScrollController _controllerMinute;
  late FixedExtentScrollController _controllerMeridiem;
  late int _step;

  final int _hourCount = 12;
  final int _minuteCount = 60;

  @override
  void initState() {
    super.initState();
    _selectDate = widget.intialDate ?? DateTime.now();
    _focusMonth = DateTime(_selectDate.year, _selectDate.month);
    _controllerHour = FixedExtentScrollController(
      initialItem: _selectDate.hour % 12,
    );
    _controllerMinute = FixedExtentScrollController(
      initialItem: _selectDate.minute,
    );
    _controllerMeridiem = FixedExtentScrollController(
      initialItem: _selectDate.hour ~/ 12,
    );
    _step = 1;
  }

  @override
  void dispose() {
    _controllerHour.dispose();
    _controllerMinute.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _step == 1 ? _buildDatePicker() : _buildTimePicker();
  }

  Widget _buildDatePicker() {
    return Dialog(
      backgroundColor: AppColors.bottomAppBar,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCalendarHeader(),
            Container(height: 1, color: AppColors.divier),
            const SizedBox(height: 8),
            _buildCalendar(),
            const SizedBox(height: 24),
            _buildDatePickerActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarHeader() {
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
        const Spacer(),
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
        const Spacer(),
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

  Widget _buildCalendar() {
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
          return Center(
            child: Text(
              days[index],
              style: AppTextStyle.labelSmall.copyWith(
                color: index == 0 || index == 6
                    ? AppColors.red
                    : AppColors.textPrimary,
              ),
            ),
          );
        }

        index = index - 7;
        int dayNumber = index - firstWeekDay + 1;
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
                style: AppTextStyle.bodySmallBold.copyWith(
                  color: isCurrentMonth
                      ? AppColors.textPrimary
                      : AppColors.textGray.withOpacity(0.5),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDatePickerActions() {
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
        const SizedBox(width: 6),
        Expanded(
          child: ButtonSubmit(
            text: 'Choose Time',
            textActiveColor: AppColors.white,
            activeBackgroundColor: AppColors.primary,
            onSubmit: () {
              setState(() {
                _step = 2;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimePicker() {
    return Dialog(
      backgroundColor: AppColors.bottomAppBar,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Choose Time', style: AppTextStyle.titleMediumBold),
            const SizedBox(height: 8),
            Container(color: AppColors.divier, height: 1),
            const SizedBox(height: 24),
            _buildTimePickerWheels(),
            const SizedBox(height: 24),
            _buildTimePickerActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePickerWheels() {
    return SizedBox(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(4),
            ),
            child: AnimatedBuilder(
              animation: _controllerHour,
              builder: (context, child) {
                return ListWheelScrollView.useDelegate(
                  itemExtent: 24,
                  controller: _controllerHour,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: _hourCount,
                    builder: (context, index) {
                      final value = (index % _hourCount);
                      final selectedIndex = _controllerHour.hasClients
                          ? _controllerHour.selectedItem
                          : 0;
                      final distance = (index - selectedIndex).abs();
                      final double scale = distance == 0
                          ? 1.2
                          : (distance == 1 ? 0.8 : 0.6);
                      final color = distance == 0
                          ? AppColors.white
                          : AppColors.textDisabled;

                      return Center(
                        child: Transform.scale(
                          scale: scale,
                          child: Text(
                            value.toString().padLeft(2, '0'),
                            style: AppTextStyle.titleMediumBold.copyWith(
                              color: color,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              ':',
              style: AppTextStyle.titleMediumBold.copyWith(fontSize: 28),
            ),
          ),
          Container(
            width: 64,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(8),
            ),
            child: AnimatedBuilder(
              animation: _controllerMinute,
              builder: (context, child) {
                return ListWheelScrollView.useDelegate(
                  itemExtent: 24,
                  controller: _controllerMinute,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: _minuteCount,
                    builder: (context, index) {
                      final value = (index % _minuteCount);
                      final selectedIndex = _controllerMinute.hasClients
                          ? _controllerMinute.selectedItem
                          : 0;
                      final distance = (index - selectedIndex).abs();
                      final double scale = distance == 0
                          ? 1.2
                          : (distance == 1 ? 0.8 : 0.6);
                      final color = distance == 0
                          ? AppColors.white
                          : AppColors.textDisabled;

                      return Center(
                        child: Transform.scale(
                          scale: scale,
                          child: Text(
                            value.toString().padLeft(2, '0'),
                            style: AppTextStyle.titleMediumBold.copyWith(
                              color: color,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 64,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(8),
            ),
            child: AnimatedBuilder(
              animation: _controllerMeridiem,
              builder: (context, child) {
                return ListWheelScrollView.useDelegate(
                  itemExtent: 24,
                  controller: _controllerMeridiem,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 2,
                    builder: (context, index) {
                      final value = index;
                      final selectedIndex = _controllerMeridiem.hasClients
                          ? _controllerMeridiem.selectedItem
                          : 0;
                      final distance = (index - selectedIndex).abs();
                      final double scale = distance == 0
                          ? 1.2
                          : (distance == 1 ? 0.8 : 0.6);
                      final color = distance == 0
                          ? AppColors.white
                          : AppColors.textDisabled;

                      return Center(
                        child: Transform.scale(
                          scale: scale,
                          child: Text(
                            value == 0 ? 'AM' : 'PM',
                            style: AppTextStyle.titleMediumBold.copyWith(
                              color: color,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePickerActions() {
    return Row(
      children: [
        Expanded(
          child: ButtonSubmit(
            text: 'Cancel',
            textActiveColor: AppColors.primary,
            activeBackgroundColor: AppColors.transparent,
            onSubmit: () {
              setState(() {
                _step = 1;
              });
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ButtonSubmit(
            onSubmit: () {
              final selectedDateTime = _buildSelectedDateTime();
              context.pop(selectedDateTime);
            },
            text: 'Save',
            textActiveColor: AppColors.textPrimary,
            activeBackgroundColor: AppColors.primary,
          ),
        ),
      ],
    );
  }

  DateTime _buildSelectedDateTime() {
    int hour24;
    if (_controllerMeridiem.selectedItem == 0) {
      hour24 = _controllerHour.selectedItem;
    } else {
      hour24 = _controllerHour.selectedItem + 12;
    }

    return DateTime(
      _selectDate.year,
      _selectDate.month,
      _selectDate.day,
      hour24,
      _controllerMinute.selectedItem,
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

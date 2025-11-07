import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/core/widgets/custom_clickable_container.dart';
import 'package:taska/core/widgets/custom_icons/custom_icons_icons.dart';

class EditTaskTime extends StatefulWidget {
  const EditTaskTime({
    super.key,
    required this.date,
    required this.onSavedTime,
  });
  final DateTime date;
  final Function(DateTime) onSavedTime;
  @override
  State<EditTaskTime> createState() => _EditTaskTimeState();
}

class _EditTaskTimeState extends State<EditTaskTime> {
  late DateTime initialDate;
  DateTime? selectedDate;
  TimeOfDay? selectedTimeOfDay;
  @override
  void initState() {
    super.initState();
    initialDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(CustomIcons.clock_icon),
        SizedBox(width: 8.w),
        Text(
          StringsManager.taskTime.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Spacer(),
        CustomClickableContainer(
          text:
              '${initialDate.year}/${initialDate.month}/${initialDate.day} ${initialDate.hour == 0 ? '00' : initialDate.hour}:${initialDate.minute == 0 ? '00' : initialDate.minute}',
          onTap: () {
            _showCalendarAndTime(context);
          },
        ),
      ],
    );
  }

  Future<void> _showCalendarAndTime(BuildContext context) async {
    selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2223),
      confirmText: StringsManager.chooseTime.tr(),
      initialDate: initialDate,
    );
    if (selectedDate != null && context.mounted) {
      selectedTimeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: initialDate.hour,
          minute: initialDate.minute,
        ),
      );
      if (selectedTimeOfDay != null) {
        DateTime selectedDateTime = DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTimeOfDay!.hour,
          selectedTimeOfDay!.minute,
        );
        if (selectedDateTime.isAfter(DateTime.now())) {
          setState(() {
            initialDate = selectedDateTime;
          });
          widget.onSavedTime(initialDate);
        }
      }
    }
  }
}

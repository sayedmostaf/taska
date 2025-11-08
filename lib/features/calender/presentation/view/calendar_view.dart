import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/calender/presentation/manager/get_tasks_by_calender_day_cubit/get_tasks_by_calender_day_cubit.dart';
import 'package:taska/features/calender/presentation/view/widgets/calendar_view_body.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetTasksByCalendarDayCubit>(context).getTasksByDay(
      day: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        0,
        0,
        0,
      ),
      isCompleted: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CalendarViewBody();
  }
}

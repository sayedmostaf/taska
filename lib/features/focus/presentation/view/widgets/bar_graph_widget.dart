import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/color_manager.dart';

class BarGraphWidget extends StatelessWidget {
  const BarGraphWidget({
    super.key,
    required this.weekDays,
    required this.seconds,
    required this.today,
  });
  final List<String> weekDays;
  final List<int> seconds;
  final String today;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 250.h,
        width: MediaQuery.of(context).size.width,
        child: BarChart(
          BarChartData(
            barTouchData: _buildBarTouch(context),
            alignment: BarChartAlignment.spaceAround,
            maxY:
                (seconds.reduce(
                          (value, element) => value > element ? value : element,
                        ) /
                        3600)
                    .ceil() +
                1,
            barGroups: generateBarGroups(),
            titlesData: _buildTitles(context),
            backgroundColor: Colors.transparent,
            gridData: FlGridData(show: false),
            borderData: FlBorderData(
              border: Border(
                bottom: BorderSide(color: ColorManager.graphColor, width: 2),
                left: BorderSide(color: ColorManager.graphColor, width: 2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BarTouchData _buildBarTouch(BuildContext context) {
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (group) => ColorManager.primaryColor,
        // tooltipBgColor: ColorManager.primaryColor,
        tooltipPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          return BarTooltipItem(
            _formatTime(seconds[groupIndex].toInt()),
            Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.white,
              fontSize: 10.sp,
            ),
          );
        },
      ),
    );
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int remainingSeconds = seconds % 3600;
    int minutes = remainingSeconds ~/ 60;
    String formattedTime = '';

    if (hours > 0) formattedTime += '$hours h ';
    if (minutes > 0 || hours > 0) formattedTime += '$minutes m';
    return formattedTime;
  }

  List<BarChartGroupData> generateBarGroups() {
    List<BarChartGroupData> barGroups = [];

    for (int i = weekDays.length - 1; i >= 0; i--) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: (seconds[i] / 3600),
              color: weekDays[i] == today
                  ? ColorManager.primaryColor
                  : ColorManager.graphColor,
              width: 30.w,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ],
        ),
      );
    }
    return barGroups;
  }

  FlTitlesData _buildTitles(BuildContext context) {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (double value, TitleMeta meta) {
            return Text(
              weekDays[value.toInt()],
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color:
                    weekDays[value.toInt()] == 'SUN' ||
                        weekDays[value.toInt()] == 'SAT'
                    ? Colors.red
                    : null,
              ),
            );
          },
        ),
      ),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30.w,
          getTitlesWidget: (double value, TitleMeta meta) {
            return Text(
              '${value.toInt().toString()} h',
              style: Theme.of(context).textTheme.labelSmall,
            );
          },
        ),
      ),
    );
  }
}

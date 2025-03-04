import 'package:flutter/material.dart';
import 'package:horizontal_scrollable_calendar/src/calendar.dart';
import 'package:horizontal_scrollable_calendar/src/date_extension.dart';
import 'package:intl/intl.dart';

class DayWidget extends StatelessWidget {
  final DateTime day;
  final bool isSelected;
  final Function(DateTime)? onSelect;
  final bool isDisabled;
  const DayWidget({
    super.key,
    required this.day,
    required this.isSelected,
    this.onSelect,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    final borderColor = isSelected || day.isToday
        ? color
        : isDisabled
            ? Colors.grey[200]!
            : Colors.grey[400]!;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => onSelect?.call(day),
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: dayWidgetWidth,
              width: dayWidgetWidth,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? color : null,
                border: Border.all(color: borderColor),
              ),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : null,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(DateFormat("EE").format(day)),
        ],
      ),
    );
  }
}

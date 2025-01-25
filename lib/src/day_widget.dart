import 'package:flutter/material.dart';
import 'package:horizontal_scrollable_calendar/src/calendar.dart';
import 'package:intl/intl.dart';

class DayWidget extends StatelessWidget {
  final DateTime day;
  final bool isSelected;
  final Function(DateTime)? onSelect;
  const DayWidget({
    super.key,
    required this.day,
    required this.isSelected,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final color = Colors.purple;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: ()=> onSelect?.call(day),
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: dayWidgetWidth,
              width: dayWidgetWidth,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? color : null,
                border: Border.all(color: isSelected ? color : Colors.grey[200]!),
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

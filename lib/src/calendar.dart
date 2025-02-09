import 'package:flutter/material.dart';
import 'package:horizontal_scrollable_calendar/src/date_extension.dart';
import 'package:horizontal_scrollable_calendar/src/day_widget.dart';
import 'package:horizontal_scrollable_calendar/src/year_month_picker.dart';
import 'package:intl/intl.dart';

const double dayWidgetWidth = 40;

class HorizontalScrollableCalendar extends StatefulWidget {
  final Function(DateTime)? onSelect;
  const HorizontalScrollableCalendar({super.key, this.onSelect});
  @override
  State<HorizontalScrollableCalendar> createState() =>
      _HorizontalScrollableCalendarState();
}

class _HorizontalScrollableCalendarState
    extends State<HorizontalScrollableCalendar> {
  DateTime get now => DateTime.now();
  List<DateTime> months = [];
  List<DateTime> days = [];

  setupMonths() {
    for (int i = 0; i < 12; i++) {
      months.add(DateTime(now.year, now.month + i));
    }
  }

  setupDays() {
    days = [];
    int i = 1;
    while (DateTime(selectedMonth.year, selectedMonth.month, i).month ==
        selectedMonth.month) {
      days.add(DateTime(selectedMonth.year, selectedMonth.month, i));
      i++;
    }
  }

  final scrollController = ScrollController();

  /// Selectable options
  DateTime selectedMonth = DateTime.now().monthOnly;
  DateTime? selectedDate = DateTime.now().dayOnly;

  @override
  void initState() {
    setupMonths();
    setupDays();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
      final itemWidth = dayWidgetWidth + 8;
      final valueToScroll = (itemWidth * (selectedDate?.day ?? 1)) - itemWidth;
      scrollController.jumpTo(valueToScroll);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            border: Border.all(color: Colors.grey),
          ),
          child: InkWell(
            onTap: () async {
              final month = await YearMonthPicker(
                initialTime: selectedMonth,
              ).selectDate(context);
              if (month == null) return;
              selectedMonth = month;
              selectedDate = null;
              setupDays();
              scrollController.jumpTo(0);
              setState(() {});
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_month_outlined),
                const SizedBox(width: 8),
                Builder(builder: (_) {
                  final monthText =
                      DateFormat("MMMM yyyy").format(selectedMonth);
                  return Text(monthText);
                }),
                const SizedBox(width: 8),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 100,
          child: ListView.builder(
            controller: scrollController,
            itemCount: days.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return DayWidget(
                day: days[index],
                isSelected: selectedDate?.dayOnly == days[index].dayOnly,
                isDisabled: days[index].isBefore(DateTime.now().dayOnly),
                onSelect: (date) => setState(() {
                  selectedDate = date;
                  widget.onSelect?.call(date);
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}

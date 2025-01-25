import 'package:flutter/material.dart';
import 'package:horizontal_scrollable_calendar/src/date_extension.dart';
import 'package:horizontal_scrollable_calendar/src/day_widget.dart';
import 'package:intl/intl.dart';

const double dayWidgetWidth = 40;
class CustomDatePicker extends StatefulWidget {
  final Function(DateTime)? onSelect;
  const CustomDatePicker({super.key, this.onSelect});
  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.calendar_month_outlined),
              const SizedBox(width: 8),
              SizedBox(
                width: 200,
                child: DropdownButtonFormField<DateTime>(
                  decoration: InputDecoration(border: InputBorder.none),
                  isExpanded: true,
                  value: selectedMonth,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: months.map((e) {
                    final monthText = DateFormat("MMMM yyyy").format(e);
                    return DropdownMenuItem(child: Text(monthText), value: e);
                  }).toList(),
                  onChanged: (newValue) {
                    selectedMonth = newValue!;
                    selectedDate = null;
                    setupDays();
                    scrollController.jumpTo(0);
                    setState(() {});
                  },
                ),
              ),
            ],
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
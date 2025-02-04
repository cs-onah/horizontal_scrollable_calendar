import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YearMonthPicker extends StatefulWidget {
  final DateTime? initialTime;
  Future<DateTime?> selectDate(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return this;
      },
    );
  }

  const YearMonthPicker({super.key, this.initialTime});
  @override
  State<YearMonthPicker> createState() => _YearMonthPickerState();
}

class _YearMonthPickerState extends State<YearMonthPicker> {
  List<int> years = [];
  List<int> months = [];

  int? selectedYear;
  int? selectedMonth;

  @override
  void initState() {
    // Initialize values
    selectedYear = widget.initialTime?.year;
    selectedMonth = widget.initialTime?.month;

    // setup option list
    final now = DateTime.now();
    for (int i = now.year; i < 12; i++) {
      years.add(i);
    }
    selectedYear = years.firstOrNull;
    for (int i = now.month; i < 12; i++) {
      months.add(i);
    }
    selectedMonth = months.firstOrNull;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.keyboard_arrow_left_outlined),
              Spacer(),
              Icon(Icons.close),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Year and month",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 18),

          /// Year Picker
          Text(
            "Year",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final year = years[index];
                return PickerBox(
                  text: "$year",
                  onTap: () => setState(() => selectedYear = year),
                  isSelected: year == selectedYear,
                );
              },
              separatorBuilder: (_, __) => SizedBox(width: 16),
              itemCount: years.length,
            ),
          ),

          const SizedBox(height: 18),

          /// Month Picker
          Text(
            "Month",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 35,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final month = months[index];
                final displayDate = DateTime(2024, month);
                final monthText = DateFormat("MMMM").format(displayDate);
                return PickerBox(
                  text: monthText,
                  onTap: () => setState(() => selectedMonth = month),
                  isSelected: month == selectedMonth,
                );
              },
              separatorBuilder: (_, __) => SizedBox(width: 16),
              itemCount: months.length,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              try {
                if (selectedYear == null) throw "Select a year";
                if (selectedMonth == null) throw "Select a month";
                Navigator.of(context).pop(
                  DateTime(selectedYear!, selectedMonth!),
                );
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error.toString())),
                );
              }
            },
            child: Text("Done"),
          ),
        ],
      ),
    );
  }
}

class PickerBox extends StatelessWidget {
  final bool isSelected;
  final String? text;
  final VoidCallback? onTap;
  const PickerBox({super.key, this.isSelected = false, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = Colors.purple;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        border: Border.all(color: isSelected ? color : Colors.grey),
      ),
      child: Text(
        "$text",
        style: TextStyle(color: isSelected ? color : Colors.grey),
      ),
    );
  }
}

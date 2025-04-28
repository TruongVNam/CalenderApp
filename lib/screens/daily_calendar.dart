import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/calendar_theme.dart';
import '../components/app_footer.dart';
import '../components/lunar_lookup.dart';

class DailyCalendarScreen extends StatelessWidget {
  final DateTime date;

  const DailyCalendarScreen({required this.date});

  @override
  Widget build(BuildContext context) {
    final daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    final List<String> hours = List.generate(25, (i) => "${i.toString().padLeft(2, '0')}:00");
    final lunarDay = LunarLookup.getFullLunarDescription(date);

    return Scaffold(
      backgroundColor: CalendarTheme.isDark(context) ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: CalendarTheme.primaryTextColor(context),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Column(
                    children: [
                      Text(
                        DateFormat('EEE, d/M/y', 'vi').format(date),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: CalendarTheme.primaryTextColor(context),
                        ),
                      ),
                      Text(
                        '${lunarDay}',
                        style: TextStyle(
                          fontSize: 12,
                          color: CalendarTheme.primaryTextColor(context).withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.view_module),
                    color: CalendarTheme.primaryTextColor(context),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.grey),
            Expanded(
              child: ListView.builder(
                itemCount: hours.length,
                itemBuilder: (context, index) {
                  final hourLabel = hours[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          child: Text(
                            hourLabel,
                            style: TextStyle(
                              fontSize: 14,
                              color: CalendarTheme.primaryTextColor(context).withOpacity(0.7),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: const Text(''),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            // const AppFooter(),
          ],
        ),
      ),
    );
  }
}
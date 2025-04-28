import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/calendar_theme.dart';
import '../theme/app_dimens.dart';
import 'monthly_calendar.dart';

class YearlyCalendarScreen extends StatefulWidget {
  const YearlyCalendarScreen({super.key});

  static const int startYear = 1900;
  static const int endYear = 2100;

  @override
  State<YearlyCalendarScreen> createState() => _YearlyCalendarScreenState();
}

class _YearlyCalendarScreenState extends State<YearlyCalendarScreen> {
  final ScrollController _scrollController = ScrollController();
  static const double yearSectionHeight = 400.0;

  @override
  Widget build(BuildContext context) {
    final years = List.generate(
        YearlyCalendarScreen.endYear - YearlyCalendarScreen.startYear + 1,
        (i) => YearlyCalendarScreen.startYear + i);

    return Scaffold(
      backgroundColor: CalendarTheme.backgroundColor(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CalendarTheme.headerBackground(context),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: years.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final year = years[index];
          return _buildYearSection(context, year);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: CalendarTheme.footerBackground(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  final currentYear = DateTime.now().year;
                  final index = currentYear - YearlyCalendarScreen.startYear;
                  final offset = index * yearSectionHeight;
                  _scrollController.animateTo(
                    offset,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('Today', style: TextStyle(color: Colors.redAccent)),
              ),
              IconButton(icon: const Icon(Icons.spa), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildYearSection(BuildContext context, int year) {
    return SizedBox(
      height: yearSectionHeight,
      child: GridView.count(
        crossAxisCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.1,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        mainAxisSpacing: 12,
        crossAxisSpacing: 8,
        children: List.generate(15, (i) {
          if (i == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$year',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(height: 4),
                Divider(
                  color: CalendarTheme.headerBackground(context),
                  thickness: 1.2,
                ),
              ],
            );
          } else if (i == 1 || i == 2) {
            return const SizedBox.shrink(); // ẩn 2 ô còn lại của hàng năm
          }

          final month = i - 2;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MonthlyCalendarScreen(
                    initialYear: year,
                    initialMonth: month,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.MMM().format(DateTime(year, month)),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}


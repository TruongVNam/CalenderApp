import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/lunar_lookup.dart';
import '../theme/calendar_theme.dart';
import '../theme/app_dimens.dart';
import 'daily_calendar.dart';

class MonthlyCalendarScreen extends StatefulWidget {
  final int initialYear;
  final int initialMonth;

  const MonthlyCalendarScreen({
    required this.initialYear,
    required this.initialMonth,
  });

  @override
  _MonthlyCalendarScreenState createState() => _MonthlyCalendarScreenState();
}

class _MonthlyCalendarScreenState extends State<MonthlyCalendarScreen> {
  late PageController _pageController;
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime(widget.initialYear, widget.initialMonth);
    _pageController = PageController(initialPage: _dateToPageIndex(_currentDate));
  }

  int _dateToPageIndex(DateTime date) => date.year * 12 + date.month;
  DateTime _pageIndexToDate(int index) =>
      DateTime(index ~/ 12, index % 12 == 0 ? 12 : index % 12);

  @override
  Widget build(BuildContext context) {
    final daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Scaffold(
      backgroundColor: CalendarTheme.isDark(context) ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: CalendarTheme.primaryTextColor(context),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    DateFormat("MMMM yyyy", 'vi').format(_currentDate).toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: CalendarTheme.primaryTextColor(context),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: daysOfWeek
                    .map((d) => Expanded(
                          child: Center(
                            child: Text(
                              d,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: CalendarTheme.primaryTextColor(context).withOpacity(0.7),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
            ),
            Expanded(
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentDate = _pageIndexToDate(index);
                  });
                },
                itemBuilder: (context, index) {
                  final monthDate = _pageIndexToDate(index);
                  return _buildMonthTable(context, monthDate);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthTable(BuildContext context, DateTime date) {
    final rowHeight = MediaQuery.of(context).size.height / 10;
    final year = date.year;
    final month = date.month;
    final daysInMonth = DateUtils.getDaysInMonth(year, month);
    final firstWeekday = (DateTime(year, month, 1).weekday % 7);
    final totalBoxes = ((daysInMonth + firstWeekday + 6) / 7).floor() * 7;

    return Table(
      border: TableBorder(
        horizontalInside: BorderSide(color: Colors.grey.shade300, width: 0.8),
      ),
      children: List.generate(totalBoxes ~/ 7, (rowIndex) {
        return TableRow(
          children: List.generate(7, (colIndex) {
            int boxIndex = rowIndex * 7 + colIndex;
            int dayNumber = boxIndex - firstWeekday + 1;
            if (dayNumber < 1 || dayNumber > daysInMonth) {
              return SizedBox(height: rowHeight);
            }
            final current = DateTime(year, month, dayNumber);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DailyCalendarScreen(date: current),
                  ),
                );
              },
              child: Container(
                height: rowHeight,
                alignment: Alignment.center,
                child: _buildDayCell(context, current,
                    isToday: _isToday(current),
                    isSelected: isSameDay(_currentDate, current)),
              ),
            );
          }),
        );
      }),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year && now.month == date.month && now.day == date.day;
  }

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Widget _buildDayCell(BuildContext context, DateTime day,
      {bool isToday = false, bool isSelected = false}) {
    final lunarDay = LunarLookup.getShortLunarDate(day);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: isToday || isSelected
              ? BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                )
              : null,
          child: Text(
            '${day.day}',
            style: TextStyle(
              fontSize: 18,
              color: isToday || isSelected
                  ? Colors.white
                  : CalendarTheme.primaryTextColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          lunarDay,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isToday || isSelected ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }
}

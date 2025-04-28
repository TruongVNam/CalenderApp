import 'package:flutter/material.dart';
import 'components/app_footer.dart';
import 'components/app_header.dart';
import 'screens/yearly_calendar.dart'; // Sử dụng YearlyCalendarScreen
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('vi', null); // Khởi tạo locale tiếng Việt
  runApp(MyCalendarApp());
}

class MyCalendarApp extends StatelessWidget {
  const MyCalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lịch năm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const AppHeader(), // Không truyền gì nữa
              const Expanded(
                child: YearlyCalendarScreen(), // Đúng component mới của bạn
              ),
              AppFooter(
                onTodayPressed: () {
                  // TODO: cuộn về năm hiện tại
                },
                onRightActionPressed: () {
                  // TODO: mở tính năng chăm sóc / mua sắm
                },
                rightIcon: Icons.shopping_bag, // hoặc Icons.spa, Icons.health_and_safety
              ),
            ],
          ),
        ),
      ),
    );
  }
}
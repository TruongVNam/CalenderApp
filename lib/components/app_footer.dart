import 'package:flutter/material.dart';
import '../theme/calendar_theme.dart';

class AppFooter extends StatelessWidget {
  final VoidCallback onTodayPressed;
  final VoidCallback onRightActionPressed;
  final IconData rightIcon;

  const AppFooter({
    super.key,
    required this.onTodayPressed,
    required this.onRightActionPressed,
    this.rightIcon = Icons.spa, // ví dụ: spa = thiền, có thể đổi thành shopping_bag, fitness_center,...
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: CalendarTheme.footerBackground(context), // đồng bộ màu header
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: onTodayPressed,
              child: const Text(
                'Today',
                style: TextStyle(
                  color: CalendarTheme.footerTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: Icon(rightIcon, color: CalendarTheme.footerTextColor),
              tooltip: 'Chăm sóc / Mua sắm',
              onPressed: onRightActionPressed,
            ),
          ],
        ),
      ),
    );
  }
}
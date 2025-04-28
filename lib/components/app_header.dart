import 'package:flutter/material.dart';
import '../theme/calendar_theme.dart';
import '../theme/app_dimens.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.headerHeight + MediaQuery.of(context).padding.top,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        right: AppDimens.iconPadding,
        left: AppDimens.iconPadding,
      ),
      color: CalendarTheme.headerBackground(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Tìm kiếm sự kiện',
            color: CalendarTheme.themeToggleIconColor(context),
            onPressed: () {
              // TODO: search logic
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Thêm sự kiện',
            color: CalendarTheme.themeToggleIconColor(context),
            onPressed: () {
              // TODO: add event logic
            },
          ),
        ],
      ),
    );
  }
}

import 'package:lunar/lunar.dart';

class LunarLookup {

  static const Map<String, String> _canChiMap = {
    '甲子': 'Giáp Tý',  '乙丑': 'Ất Sửu',  '丙寅': 'Bính Dần',  '丁卯': 'Đinh Mão',
    '戊辰': 'Mậu Thìn', '己巳': 'Kỷ Tỵ',   '庚午': 'Canh Ngọ',  '辛未': 'Tân Mùi',
    '壬申': 'Nhâm Thân','癸酉': 'Quý Dậu', '甲戌': 'Giáp Tuất','乙亥': 'Ất Hợi',
    '丙子': 'Bính Tý',  '丁丑': 'Đinh Sửu','戊寅': 'Mậu Dần',  '己卯': 'Kỷ Mão',
    '庚辰': 'Canh Thìn','辛巳': 'Tân Tỵ',  '壬午': 'Nhâm Ngọ', '癸未': 'Quý Mùi',
    '甲申': 'Giáp Thân','乙酉': 'Ất Dậu',  '丙戌': 'Bính Tuất','丁亥': 'Đinh Hợi',
    '戊子': 'Mậu Tý',   '己丑': 'Kỷ Sửu',  '庚寅': 'Canh Dần', '辛卯': 'Tân Mão',
    '壬辰': 'Nhâm Thìn','癸巳': 'Quý Tỵ',  '甲午': 'Giáp Ngọ', '乙未': 'Ất Mùi',
    '丙申': 'Bính Thân','丁酉': 'Đinh Dậu','戊戌': 'Mậu Tuất','己亥': 'Kỷ Hợi',
    '庚子': 'Canh Tý',  '辛丑': 'Tân Sửu', '壬寅': 'Nhâm Dần','癸卯': 'Quý Mão',
    '甲辰': 'Giáp Thìn','乙巳': 'Ất Tỵ',   '丙午': 'Bính Ngọ', '丁未': 'Đinh Mùi',
    '戊申': 'Mậu Thân','己酉': 'Kỷ Dậu',  '庚戌': 'Canh Tuất','辛亥': 'Tân Hợi',
    '壬子': 'Nhâm Tý',  '癸丑': 'Quý Sửu', '甲寅': 'Giáp Dần','乙卯': 'Ất Mão',
    '丙辰': 'Bính Thìn','丁巳': 'Đinh Tỵ', '戊午': 'Mậu Ngọ', '己未': 'Kỷ Mùi',
    '庚申': 'Canh Thân','辛酉': 'Tân Dậu','壬戌': 'Nhâm Tuất','癸亥': 'Quý Hợi',
  };

  /// Trả về dạng: "12/Tháng 2" hoặc "23/Tháng Nhuận 7"
  static String getLunarDate(DateTime date) {
    final solar = Solar.fromDate(date);
    final lunar = solar.getLunar();
    final day = lunar.getDay();
    final month = lunar.getMonth();

    // Kiểm tra nếu tháng này là tháng nhuận
    final lunarYear = LunarYear.fromYear(lunar.getYear());
    final leapMonth = lunarYear.getLeapMonth();
    final isLeap = leapMonth > 0 && month == leapMonth;

    return isLeap ? '$day/Tháng Nhuận $month' : '$day/Tháng $month';
  }

  static String getShortLunarDate(DateTime date) {
    final solar = Solar.fromDate(date);
    final lunar = solar.getLunar();
    final day = lunar.getDay();
    final month = lunar.getMonth();
    final isFirstDay = day == 1;

    return isFirstDay ? '$day/$month' : '$day';
  }

  static String getFullLunarDescription(DateTime date) {
    final solar = Solar.fromDate(date);
    final lunar = solar.getLunar();

    final day = lunar.getDay();
    final month = lunar.getMonth();
    final yearHan = lunar.getYearInGanZhi();
    final yearVi = _canChiMap[yearHan] ?? yearHan; // dịch nếu có, fallback nếu không

    return '$day/$month/$yearVi';
  }
}

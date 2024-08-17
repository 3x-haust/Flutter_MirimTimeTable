import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

Future<Map<String, dynamic>> getTimeData(int grade, cls, code, String schoolNum) async {
  String? key = dotenv.env['KEY'];

  List<String> weekdays = ["월", "화", "수", "목", "금"];
  int todayIndex = DateTime.now().weekday - 1;
  List<String> targetDays = weekdays.sublist(todayIndex);
  if (todayIndex == 2) {
    targetDays.addAll(weekdays.sublist(0, todayIndex));
  }
  List<String> targetDates = targetDays.map((day) {
    DateTime date = DateTime.now().add(Duration(days: weekdays.indexOf(day) - todayIndex));
    return DateFormat("yyyyMMdd").format(date);
  }).toList();

  targetDates.sort();

  List<String> timeTableNames = List.empty();
    
  for(int i = 0; i < 7; i++){
    final response =
      await http.get(Uri.parse('https://open.neis.go.kr/hub/hisTimetable?Key=${key}&Type=json&ATPT_OFCDC_SC_CODE=${schoolNum}&SD_SCHUL_CODE=${code}&ALL_TI_YMD=${targetDates[i]}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      Map<String, dynamic> timeTable = data['hisTimetable'][1]['row'];

      timeTableNames.add(timeTable['ITRT_CNTNT']);
    } else {
      throw Exception('Failed to load meal data');
    }
  }

  return {
    "timeTableNames": "a",
  };
}
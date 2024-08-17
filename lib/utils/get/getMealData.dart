import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

Future<Map<String, dynamic>> getMealData(int meal, DateTime dt) async {
  String? key = dotenv.env['KEY'];
  String date = DateFormat("yyyyMMdd").format(dt);

  final response =
      await http.get(Uri.parse('https://open.neis.go.kr/hub/mealServiceDietInfo?Key=${key}&Type=json&ATPT_OFCDC_SC_CODE=B10&SD_SCHUL_CODE=7011569&MLSV_YMD=${date}'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);

    Map<String, dynamic> mealData = data['mealServiceDietInfo'][1]['row'][meal]; 
    List<String> dishName = mealData['DDISH_NM'].split('<br/>');
    final String mealCal = mealData['CAL_INFO'];
    final String mealName = mealData['MMEAL_SC_NM'];

    dishName = dishName.map((dish) {
      return dish
          .replaceAll(RegExp(r'<[^>]*>'), '')
          .replaceAll(RegExp(r'\([^)]*\)'), '')
          .replaceAll(' ', '')
          .replaceAll('*', '')
          .replaceAll('.', '');
    }).toList();

    return {
      "dishName": dishName,
      "mealName": mealName,
      "mealCal": mealCal
    };
  } else {
    throw Exception('Failed to load meal data');
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:schooltimetable/pages/main/main_page.dart';
import 'package:schooltimetable/pages/main/meal_page.dart';
import 'package:schooltimetable/pages/main/timetable_page.dart';
import 'package:schooltimetable/pages/setting/setting_page.dart';
import 'package:schooltimetable/pages/notification/notification_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:schooltimetable/pages/setting/settting_data_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  
  final prefs = await SharedPreferences.getInstance();
  final school = prefs.getString('school');
  final grade = prefs.getString('grade');
  final classValue = prefs.getString('class');
    
  final hasSettings = school != null && grade != null && classValue != null;

  runApp(MyApp(initialRoute: hasSettings ? '/' : '/'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => const MainPage()),
        GetPage(name: '/timetable', page: () => const TimeTablePage()),
        GetPage(name: '/meal', page: () => const MealPage()),
        GetPage(name: '/setting', page: () => const SettingPage()),
        GetPage(name: '/notification', page: () => const NotificationPage()),
        GetPage(name: '/setdata', page: () => const SetDataPage()),
      ],
      home: initialRoute == '/' ? const MainPage() : const SetDataPage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      locale: const Locale('ko'),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:schooltimetable/utils/get/getTimeData.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimeTablePage createState() => _TimeTablePage();
}

class _TimeTablePage extends State<TimeTablePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF2F4F6),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            TimeTableCard(),
          ],
        ),
      ),
    );
  }
}

class TimeTableCard extends StatefulWidget {
  const TimeTableCard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TImeTableCardState createState() => _TImeTableCardState();
}

class _TImeTableCardState extends State<TimeTableCard> {
  String selectedMeal = '중식';
  int mealIndex = 1;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '시간표',
                    style: TextStyle(
                      color: Color(0xFF101012),
                      fontSize: 24,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Center(
              child: Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFF0F543C),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 24.0,
                    left: screenWidth * 0.3,
                    right: screenWidth * 0.3,
                    bottom: 16.0,
                  ),
                  child: FutureBuilder(
                    future: getTimeData(1, 2, 7011569, "B10"),
                    builder: (BuildContext context, AsyncSnapshot mealDataSnapshot) {
                      if (mealDataSnapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (mealDataSnapshot.hasError) {
                        return const FittedBox(
                          fit: BoxFit.none,
                          child: Text(
                            '데이터가 없습니다',
                            // ignore: deprecated_member_use
                            textScaleFactor: 1.3,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      } else {
                        List<String> dishNames = mealDataSnapshot.data['dishName'];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: dishNames.map((menu) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: FittedBox(
                              fit: BoxFit.none,
                              child: Text(
                                menu,
                                // ignore: deprecated_member_use
                                textScaleFactor: 1.3,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          )).toList(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
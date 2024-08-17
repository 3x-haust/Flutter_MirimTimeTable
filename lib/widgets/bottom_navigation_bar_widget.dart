import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar(
    {super.key, required this.currentIndex, required this.onTap}
  );

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFF3F4F6),
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/timetable.svg',
            width: 24,
            height: 24,
            color: currentIndex == 0 ? const Color(0xff03AA71) : null,
          ),
          label: '시간표',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/meal.svg',
            width: 24,
            height: 24,
            color: currentIndex == 1 ? const Color(0xff03AA71) : null,
          ),
          label: '급식',
        ),
      ],
      selectedItemColor: const Color(0xff03AA71),
    );
  }
}
import 'package:flutter/material.dart';

BottomNavigationBarItem customBottomNavigationItem(Icon icon) {
  return BottomNavigationBarItem(
    icon: icon,
    activeIcon: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45 / 2),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.9),
              spreadRadius: 1.5,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ]),
      width: 43,
      height: 43,
      child: icon,
    ),
    label: '',
  );
}

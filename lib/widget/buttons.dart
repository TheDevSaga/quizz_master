import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final Function onClick;
  final IconData icon;
  CircularButton({@required this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onClick,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Color(0xFF6200E2),
          borderRadius: BorderRadius.circular(150),
        ),
        child: Icon(
          icon,
          size: 70,
          color: Colors.white,
        ),
      ),
    );
  }
}

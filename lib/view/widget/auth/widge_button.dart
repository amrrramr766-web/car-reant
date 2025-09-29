import 'package:flutter/material.dart';

class WidgeButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const WidgeButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // يجعل الزر بعرض الشاشة
      height: 50, // ارتفاع الزر
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple, // لون خلفية الزر
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // حواف مستديرة
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}

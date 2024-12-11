import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(70)),
        child: Image.asset(
          'assets/images/logo.png',
          height: 40,
        ),
      ),
    );
  }
}

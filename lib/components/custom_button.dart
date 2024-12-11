import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onPressed, required this.text});
final void Function()? onPressed;
final String text;

  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
      onPressed: onPressed,
      height: 40,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      color: Colors.grey[200],
      child:  Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}

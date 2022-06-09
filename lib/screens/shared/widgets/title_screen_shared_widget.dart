import 'package:flutter/material.dart';

class TitleScreenSharedWidget extends StatelessWidget {
  final String title;
  const TitleScreenSharedWidget({ Key? key, this.title = "-" }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 32
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mahami/pages/dairy_page.dart';

class DairyInput extends StatefulWidget {
  const DairyInput({super.key});

  @override
  State<DairyInput> createState() => _DairyInputState();
}

class _DairyInputState extends State<DairyInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DairyPage()),
          ),
        ),
      ),
    );
  }
}

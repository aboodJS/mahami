import 'package:flutter/material.dart';
import 'package:mahami/pages/dairy_page.dart';
import 'package:sqflite/sqflite.dart';

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
        centerTitle: true,
        title: Text("input a dairy entry"),
        leading: BackButton(
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DairyPage()),
          ),
        ),
      ),
      body: Column(
        children: [
          Column(children: [Text("enter title"), TextField()]),
          Column(children: [Text("enter body text"), TextField()]),
          TextButton(onPressed: null, child: Text("Enter")),
        ],
      ),
    );
  }
}

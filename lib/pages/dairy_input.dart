import 'package:flutter/material.dart';
import "../main.dart";

class DairyInput extends StatefulWidget {
  const DairyInput({super.key});

  @override
  State<DairyInput> createState() => _DairyInputState();
}

class _DairyInputState extends State<DairyInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("مهامي"), centerTitle: true),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('مهامي'),
            ),
            ListTile(
              title: Text("tasks"),
              onTap: () => {
                Navigator.pop(context),
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => textInputBox()),
                ),
              },
            ),
            ListTile(
              title: Text("Dairy"),
              onTap: () => {
                Navigator.pop(context),
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => DairyInput()),
                ),
              },
            ),
            ListTile(
              title: Text("about"),
              onTap: () => {
                Navigator.pop(context),
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AboutPage()),
                ),
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade800,
        onPressed: null,
        tooltip: "click to add a diary entry",
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import "../main.dart";

class DairyPage extends StatefulWidget {
  const DairyPage({super.key});

  @override
  State<DairyPage> createState() => _DairyPageState();
}

class _DairyPageState extends State<DairyPage> {
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
                  MaterialPageRoute(builder: (context) => DairyPage()),
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

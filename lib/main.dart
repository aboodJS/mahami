import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import "package:url_launcher/url_launcher.dart";
import "files_ops.dart";

ThemeData light = ThemeData.light(useMaterial3: true);
ThemeData dark = ThemeData.dark(useMaterial3: true);

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: light,
      darkTheme: dark,
      themeMode: ThemeMode.system,
      home: textInputBox(),
    );
  }
}

class textInputBox extends StatefulWidget {
  const textInputBox({super.key});

  @override
  State<textInputBox> createState() => _textInputBoxState();
}

class _textInputBoxState extends State<textInputBox> {
  TextEditingController controller = TextEditingController();
  List<String> userInput = [];

  Future openFile() async {
    final path = await getApplicationDocumentsDirectory();
    final file = File("${path.path}/tasks.txt");
    print(file.readAsStringSync());
    setState(() {
      userInput = file.readAsStringSync().split("\n");
    });
  }

  @override
  void initState() {
    super.initState();
    openFile();
  }

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
        tooltip: "click to add a task",

        backgroundColor: Colors.green.shade800,
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: LayoutBuilder(
              builder: (context, cons) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SizedBox(
                    width: cons.maxHeight * 0.5,
                    height: cons.maxHeight * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "enter a task",
                          style: TextStyle(
                            fontWeight: FontWeight(700),
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(
                          width: cons.minWidth,
                          child: TextField(
                            controller: controller,
                            autofocus: true,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("close"),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  createFile(controller.text.trim());
                                  userInput.add(controller.text.trim());
                                  controller.clear();
                                  Navigator.pop(context);
                                });
                              },
                              child: Text("add task"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          if (userInput.every((str) => str.isEmpty))
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("there are no tasks", textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),

          for (String task in userInput)
            if (task.isNotEmpty)
              LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: Container(
                      width: constraints.maxWidth * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.green.shade800,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => setState(() {
                              userInput.removeWhere((e) => e == task);
                              print(task);
                              print(userInput);
                              deleteItem(userInput, task);
                            }),
                            icon: Icon(Icons.check, color: Colors.white),
                          ),
                          Text(
                            task,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(title: Text("مهامي")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("developed by Abdallah Jehad"),
            InkWell(
              child: Text(
                "source code",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
              onTap: () => launchUrl(
                Uri(
                  scheme: 'https',
                  host: "github.com",
                  path: 'aboodJS/mahami',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

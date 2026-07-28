import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future createFile(String str) async {
  final path = await getApplicationDocumentsDirectory();
  final file = File("${path.path}/tasks.txt");
  await file.writeAsString("$str\n", mode: FileMode.append);
}

Future deleteItem(List<String> arr, String str) async {
  final path = await getApplicationDocumentsDirectory();
  final file = File("${path.path}/tasks.txt");
  arr.removeWhere((e) => e == str);
  file.writeAsStringSync("${arr.join("\n")}\n", mode: FileMode.write);
}

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
      home: Scaffold(
        body: textInputBox(),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: null,
              icon: Icon(Icons.menu, color: Colors.white),
            ),
          ],
          title: Text("مهامي"),
          centerTitle: true,
        ),
      ),
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

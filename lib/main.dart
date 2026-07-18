import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> getPath() async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await getPath();
  return File('$path/tasks.txt');
}

Future<File> writeTasks(String task) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString('-$task\n', mode: FileMode.append);
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: textInputBox(),
        appBar: AppBar(title: Text("task Keeper"), centerTitle: true),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4),
                child: TextField(controller: controller),
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                if (controller.text.trim().isNotEmpty) {
                  userInput.add(controller.text.trim());
                  controller.clear();
                } else {
                  print("please enter a vaild string");
                }
              }),
              icon: Icon(Icons.add),
            ),
          ],
        ),
        for (String task in userInput)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(task),
              IconButton(
                onPressed: () => {
                  setState(() {
                    userInput.remove(task);
                  }),
                },

                icon: Icon(Icons.delete),
              ),
            ],
          ),
      ],
    );
  }
}

import 'package:path_provider/path_provider.dart';
import "dart:io";

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

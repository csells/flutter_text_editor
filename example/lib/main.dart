import 'package:flutter/material.dart';
import 'package:text_editor/text_editor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const title = 'Flutter Notepad';

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          actions: [
            IconButton(icon: Icon(Icons.ac_unit), onPressed: () => _controller.text = 'snow'),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: TextEditor(
                  autofocus: true,
                  controller: _controller,
                ),
              ),
            ],
          ),
        ),
      );
}

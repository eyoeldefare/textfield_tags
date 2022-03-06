import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> m = ['cool', 'college', 'cool'];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Flutter textfield tags',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: TextFieldTags(
          //initialTags: ["better", "lovely"],

          textSeparators: const [' ', '.', ','],
          tagsStyler: TagsStyler(
            showHashtag: true,
            tagMargin: const EdgeInsets.only(right: 4.0),
            tagCancelIcon: const Icon(
              Icons.cancel,
              size: 15.0,
              color: Colors.black,
            ),
            tagCancelIconPadding: const EdgeInsets.only(left: 4.0, top: 2.0),
            tagPadding: const EdgeInsets.only(
              top: 2.0,
              bottom: 4.0,
              left: 8.0,
              right: 4.0,
            ),
            tagDecoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            tagTextStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          textFieldStyler: TextFieldStyler(
            readOnly: false,
            hintText: 'Tags',
            isDense: false,
            textFieldFocusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 3.0),
            ),
            textFieldBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 3.0),
            ),
          ),
          onDelete: (tag) {
            m.remove(tag);
          },
          onTag: (tag) {
            m.add(tag);
          },
          validator: (String tag) {
            if (tag.length > 15) {
              return 'hey that is too much';
            } else if (tag.isEmpty) {
              return 'enter something';
            }

            return null;
          },
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//Tags eg: university, college, music, math, calculus, computerscience, economics, flutter

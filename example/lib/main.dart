import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter textfield tags'),
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: TextFieldTags(
          // optional initial tags
          // initialTags: <String>['Wero', 'baby'],

          //[textFieldStyler] is required and shall not be null
          textFieldStyler: TextFieldStyler(
              //These are properties you can tweek for customization of the textfield

              // bool textFieldFilled = false,
              // String helperText = 'Enter tags',
              // TextStyle helperStyle,
              // String hintText = 'Got tags?',
              // TextStyle hintStyle,
              // EdgeInsets contentPadding,
              // Color textFieldFilledColor,
              // bool isDense = true,
              // bool textFieldEnabled = true,
              // OutlineInputBorder textFieldBorder = const OutlineInputBorder(),
              // OutlineInputBorder textFieldFocusedBorder,
              // OutlineInputBorder textFieldDisabledBorder,
              // OutlineInputBorder textFieldEnabledBorder,
              // Color cursorColor,
              // TextStyle textStyle;
              ),
          //[tagsStyler] is required and shall not be null
          tagsStyler: TagsStyler(
              //These are properties you can tweek for customization of tags
              tagTextStyle: TextStyle(fontWeight: FontWeight.normal),
              tagDecoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(0.0),
              ),
              tagCancelIcon:
                  Icon(Icons.cancel, size: 18.0, color: Colors.blue[900]),
              tagPadding: const EdgeInsets.all(6.0)
              // EdgeInsets tagPadding = const EdgeInsets.all(4.0),
              // EdgeInsets tagMargin = const EdgeInsets.symmetric(horizontal: 4.0),
              // BoxDecoration tagDecoration = const BoxDecoration(color: Color.fromARGB(255, 74, 137, 92)),
              // TextStyle tagTextStyle,
              // Icon tagCancelIcon = const Icon(Icons.cancel, size: 18.0, color: Colors.green)
              // isHashTag: true,
              ),
          onTag: (tag) {
            //This give you tags entered
            print('onTag ' + tag);
          },
          onDelete: (tag) {
            print('onDelete ' + tag);
          },
          //tagsDistanceFromBorderEnd: 0.725,
          //scrollableTagsMargin: EdgeInsets.only(left: 9),
          //scrollableTagsPadding: EdgeInsets.only(left: 9),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//Tags eg: university, college, music, math, calculus, computerscience, economics, flutter

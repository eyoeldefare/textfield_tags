import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TagData Type Tag Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const Home(),
    );
  }
}

class ButtonData {
  final Color buttonColor;
  final String emoji;
  const ButtonData(this.buttonColor, this.emoji);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double _distanceToField;
  late DynamicTagController<TagData<ButtonData>> _dynamicTagController;
  final random = Random();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _dynamicTagController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _dynamicTagController = DynamicTagController<TagData<ButtonData>>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome To Zootopia",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 74, 137, 92),
          centerTitle: true,
          title: const Text(
            'TagData Type Example...',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            TextFieldTags<TagData<ButtonData>>(
              textfieldTagsController: _dynamicTagController,
              initialTags: [
                TagData(
                  'cat',
                  const ButtonData(
                    Color.fromARGB(255, 132, 204, 255),
                    "😽",
                  ),
                ),
                TagData(
                  'penguin',
                  const ButtonData(
                    Color.fromARGB(255, 255, 131, 228),
                    '🐧',
                  ),
                ),
                TagData(
                  'tiger',
                  const ButtonData(
                    Color.fromARGB(255, 222, 255, 132),
                    '🐯',
                  ),
                ),
              ],
              textSeparators: const [' ', ','],
              letterCase: LetterCase.normal,
              validator: (TagData<ButtonData> tag) {
                if (tag.tag == 'lion') {
                  return 'Not envited per tiger request';
                } else if (_dynamicTagController.getTags!.contains(tag)) {
                  return 'Already in the clube';
                }
                return null;
              },
              inputFieldBuilder: (context, inputFieldValues) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: inputFieldValues.textEditingController,
                    focusNode: inputFieldValues.focusNode,
                    decoration: InputDecoration(
                      isDense: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 74, 137, 92),
                          width: 3.0,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 74, 137, 92),
                          width: 3.0,
                        ),
                      ),
                      helperText: 'Enter language...',
                      helperStyle: const TextStyle(
                        color: Color.fromARGB(255, 74, 137, 92),
                      ),
                      hintText: inputFieldValues.tags.isNotEmpty
                          ? ''
                          : "Enter tag...",
                      errorText: inputFieldValues.error,
                      prefixIconConstraints:
                          BoxConstraints(maxWidth: _distanceToField * 0.74),
                      prefixIcon: inputFieldValues.tags.isNotEmpty
                          ? SingleChildScrollView(
                              controller: inputFieldValues.tagScrollController,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: inputFieldValues.tags
                                      .map((TagData<ButtonData> tag) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    color: tag.data.buttonColor,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        child: Text(
                                          '${tag.data.emoji} ${tag.tag}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        onTap: () {
                                          // print("${tag.tag} selected");
                                        },
                                      ),
                                      const SizedBox(width: 4.0),
                                      InkWell(
                                        child: const Icon(
                                          Icons.cancel,
                                          size: 14.0,
                                          color: Color.fromARGB(
                                              255, 233, 233, 233),
                                        ),
                                        onTap: () {
                                          inputFieldValues.onTagRemoved(tag);
                                        },
                                      )
                                    ],
                                  ),
                                );
                              }).toList()),
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      final getColor = Color.fromARGB(
                          random.nextInt(256),
                          random.nextInt(256),
                          random.nextInt(256),
                          random.nextInt(256));
                      final button = ButtonData(getColor, '✨');
                      final tagData = TagData(value, button);
                      inputFieldValues.onTagChanged(tagData);
                    },
                    onSubmitted: (value) {
                      final getColor = Color.fromARGB(
                          random.nextInt(256),
                          random.nextInt(256),
                          random.nextInt(256),
                          random.nextInt(256));
                      final button = ButtonData(getColor, '✨');
                      final tagData = TagData(value, button);
                      inputFieldValues.onTagSubmitted(tagData);
                    },
                  ),
                );
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 74, 137, 92),
                ),
              ),
              onPressed: () {
                _dynamicTagController.clearTags();
              },
              child: const Text('CLEAR TAGS'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'String Type Tag Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double _distanceToField;
  late StringTagController _stringTagController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _stringTagController = StringTagController<String>();
  }

  @override
  void dispose() {
    super.dispose();
    _stringTagController.dispose();
  }

  static const List<String> _pickLanguage = <String>[
    'c',
    'c++',
    'java',
    'python',
    'javascript',
    'php',
    'sql',
    'yaml',
    'gradle',
    'xml',
    'html',
    'flutter',
    'css',
    'dockerfile'
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome",
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 74, 137, 92),
            centerTitle: true,
            title: const Text('String Type Tag Demo...',
                style: TextStyle(color: Colors.white))),
        body: Column(
          children: [
            Autocomplete<String>(
              optionsViewBuilder: (context, onSelected, options) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Material(
                      elevation: 4.0,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final dynamic option = options.elementAt(index);
                            return TextButton(
                              onPressed: () {
                                onSelected(option);
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Text(
                                    '#$option',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 74, 137, 92),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return _pickLanguage.where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selectedTag) {
                _stringTagController.onTagSubmitted(selectedTag);
              },
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                return TextFieldTags<String>(
                  textEditingController: textEditingController,
                  focusNode: focusNode,
                  textfieldTagsController: _stringTagController,
                  initialTags: const [
                    'yaml',
                    'gradle',
                  ],
                  textSeparators: const [' ', ','],
                  letterCase: LetterCase.normal,
                  validator: (String tag) {
                    if (tag == 'php') {
                      return 'No, please just no';
                    } else if (_stringTagController.getTags!.contains(tag)) {
                      return 'You\'ve already entered that';
                    }
                    return null;
                  },
                  inputFieldBuilder: (context, inputFieldValues) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        controller: inputFieldValues.textEditingController,
                        focusNode: inputFieldValues.focusNode,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 74, 137, 92),
                                width: 3.0),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 74, 137, 92),
                                width: 3.0),
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
                                  controller:
                                      inputFieldValues.tagScrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: inputFieldValues.tags
                                          .map((String tag) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                        color: Color.fromARGB(255, 74, 137, 92),
                                      ),
                                      margin:
                                          const EdgeInsets.only(right: 10.0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Text(
                                              '#$tag',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onTap: () {
                                              //print("$tag selected");
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
                                              inputFieldValues
                                                  .onTagRemoved(tag);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()),
                                )
                              : null,
                        ),
                        onChanged: inputFieldValues.onTagChanged,
                        onSubmitted: inputFieldValues.onTagSubmitted,
                      ),
                    );
                  },
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
                _stringTagController.clearTags();
              },
              child: const Text('CLEAR TAGS'),
            ),
          ],
        ),
      ),
    );
  }
}

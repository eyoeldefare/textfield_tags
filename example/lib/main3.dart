import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Number Demo',
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
  late MyCustomController<int> _myCustomController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _myCustomController = MyCustomController<int>();
  }

  @override
  void dispose() {
    super.dispose();
    _myCustomController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome to Numbers",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 74, 137, 92),
          centerTitle: true,
          title: const Text('Enter a number...'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFieldTags<int>(
            textfieldTagsController: _myCustomController,
            initialTags: const [1, 2, 3, 4],
            textSeparators: const [' ', ','],
            letterCase: LetterCase.normal,
            validator: (int number) {
              if (number == 8) {
                return 'Eight is not allowed';
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
                          color: Color.fromARGB(255, 74, 137, 92), width: 3.0),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 74, 137, 92), width: 3.0),
                    ),
                    helperText: 'Enter language...',
                    helperStyle: const TextStyle(
                      color: Color.fromARGB(255, 74, 137, 92),
                    ),
                    hintText:
                        inputFieldValues.tags.isNotEmpty ? '' : "Enter tag...",
                    errorText: inputFieldValues.error,
                    prefixIconConstraints:
                        BoxConstraints(maxWidth: _distanceToField * 0.74),
                    prefixIcon: inputFieldValues.tags.isNotEmpty
                        ? SingleChildScrollView(
                            controller: inputFieldValues.tagScrollController,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children:
                                    inputFieldValues.tags.map((int number) {
                              return Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  color: Color.fromARGB(255, 74, 137, 92),
                                ),
                                margin: const EdgeInsets.only(right: 10.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        '#$number',
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
                                        color:
                                            Color.fromARGB(255, 233, 233, 233),
                                      ),
                                      onTap: () {
                                        inputFieldValues.onTagDelete(number);
                                      },
                                    )
                                  ],
                                ),
                              );
                            }).toList()),
                          )
                        : null,
                  ),
                  onSubmitted: (value) {
                    try {
                      int num = int.parse(value);
                      inputFieldValues.onSubmitted(num);
                    } on FormatException catch (_) {
                      _myCustomController.setError = "Must enter string value";
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyCustomController<T> extends TextfieldTagsController<T> {
  @override
  void onSubmitted(T value) {
    if (value is int) {
      String? validate = getValidator != null ? getValidator!(value) : null;
      if (validate == null && value > 2 && value < 10) {
        bool? addTag = super.addTag(value);
        if (addTag == true) {
          setError = null;
          scrollTags();
        }
      } else if (validate != null) {
        setError = validate;
      } else {
        setError = 'Must enter numbers greater than 2 and less than 10';
      }
    }
  }

  @override
  void onTagDelete(T tag) {
    bool? removed = removeTag(tag);
    if (removed == true) {
      setError = null;
    } else {
      setError = 'Failed to delete number tag';
    }
  }

  @override
  set setError(String? error) {
    super.setError = error;
    getTextEditingController?.clear();
    getFocusNode?.requestFocus();
    notifyListeners();
  }
}

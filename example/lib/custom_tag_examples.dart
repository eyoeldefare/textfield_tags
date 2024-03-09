import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class CustomTags extends StatefulWidget {
  const CustomTags({Key? key}) : super(key: key);

  @override
  State<CustomTags> createState() => _CustomTagsState();
}

class _CustomTagsState extends State<CustomTags> {
  late double _distanceToField;
  late MyIntTagController _myIntTagController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _myIntTagController = MyIntTagController();
  }

  @override
  void dispose() {
    super.dispose();
    _myIntTagController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 74, 137, 92),
        centerTitle: true,
        title: const Text(
          'Custom Type Tag Demo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFieldTags<int>(
          textfieldTagsController: _myIntTagController,
          initialTags: const [4, 5],
          textSeparators: const [' ', ','],
          letterCase: LetterCase.normal,
          validator: (int tag) {
            if (tag == 8) {
              return '8 is not allowed';
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
                  helperText: 'Enter a number...',
                  helperStyle: const TextStyle(
                    color: Color.fromARGB(255, 74, 137, 92),
                  ),
                  hintText:
                      inputFieldValues.tags.isNotEmpty ? '' : "Enter num...",
                  errorText: inputFieldValues.error,
                  prefixIconConstraints:
                      BoxConstraints(maxWidth: _distanceToField * 0.74),
                  prefixIcon: inputFieldValues.tags.isNotEmpty
                      ? SingleChildScrollView(
                          controller: inputFieldValues.tagScrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children:
                                  inputFieldValues.tags.map((int tagData) {
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
                                      '#$tagData',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
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
                                      color: Color.fromARGB(255, 233, 233, 233),
                                    ),
                                    onTap: () {
                                      inputFieldValues.onTagRemoved(tagData);
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
                    inputFieldValues.onTagSubmitted(num);
                  } on FormatException catch (_) {
                    _myIntTagController.setError = "Must enter int";
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyIntTagController<T extends int> extends TextfieldTagsController<T> {
  @override
  bool? onTagSubmitted(T tag) {
    String? validate = getValidator != null ? getValidator!(tag) : null;
    getTextEditingController?.clear();
    getFocusNode?.requestFocus();
    if (validate == null && tag > 2 && tag < 10) {
      bool? addTag = super.addTag(tag);
      if (addTag == true) {
        setError = null;
        scrollTags();
      }
    } else if (validate != null) {
      super.setError = validate;
    } else {
      super.setError = 'Must enter numbers between 2 and 10';
    }
    notifyListeners();
    return null;
  }

  @override
  set setError(String? error) {
    super.setError = error;
    getTextEditingController?.clear();
    getFocusNode?.requestFocus();
    notifyListeners();
  }
}

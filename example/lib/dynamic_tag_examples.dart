import 'package:textfield_tags/textfield_tags.dart';
import 'dart:math';
import 'package:flutter/material.dart';

/*
 * Dynamic Tags 
 */
class ButtonData {
  final Color buttonColor;
  final String emoji;
  const ButtonData(this.buttonColor, this.emoji);
}

class DynamicTags extends StatefulWidget {
  const DynamicTags({Key? key}) : super(key: key);

  @override
  State<DynamicTags> createState() => _DynamicTagsState();
}

class _DynamicTagsState extends State<DynamicTags> {
  late double _distanceToField;
  late DynamicTagController<DynamicTagData<ButtonData>> _dynamicTagController;
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
    _dynamicTagController = DynamicTagController<DynamicTagData<ButtonData>>();
  }

  static final List<DynamicTagData<ButtonData>> _initialTags = [
    DynamicTagData<ButtonData>(
      'cat',
      const ButtonData(
        Color.fromARGB(255, 200, 232, 255),
        "😽",
      ),
    ),
    DynamicTagData(
      'penguin',
      const ButtonData(
        Color.fromARGB(255, 255, 201, 243),
        '🐧',
      ),
    ),
    DynamicTagData(
      'tiger',
      const ButtonData(
        Color.fromARGB(255, 240, 255, 200),
        '🐯',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 74, 137, 92),
        centerTitle: true,
        title: const Text(
          'Dynamic Tag Demo...',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          TextFieldTags<DynamicTagData<ButtonData>>(
            textfieldTagsController: _dynamicTagController,
            initialTags: _initialTags,
            textSeparators: const [' ', ','],
            letterCase: LetterCase.normal,
            validator: (DynamicTagData<ButtonData> tag) {
              if (tag.tag == 'lion') {
                return 'Not envited per tiger request';
              } else if (_dynamicTagController.getTags!
                  .any((element) => element.tag == tag.tag)) {
                return 'Already in the club';
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
                    helperText: 'Zootopia club...',
                    helperStyle: const TextStyle(
                      color: Color.fromARGB(255, 74, 137, 92),
                    ),
                    hintText: inputFieldValues.tags.isNotEmpty
                        ? ''
                        : "Register name...",
                    errorText: inputFieldValues.error,
                    prefixIconConstraints:
                        BoxConstraints(maxWidth: _distanceToField * 0.75),
                    prefixIcon: inputFieldValues.tags.isNotEmpty
                        ? SingleChildScrollView(
                            controller: inputFieldValues.tagScrollController,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: inputFieldValues.tags
                                    .map((DynamicTagData<ButtonData> tag) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  color: tag.data.buttonColor,
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
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
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
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
                                        color: Color.fromARGB(255, 0, 0, 0),
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
                    final tagData = DynamicTagData(value, button);
                    inputFieldValues.onTagChanged(tagData);
                  },
                  onSubmitted: (value) {
                    final getColor = Color.fromARGB(
                        random.nextInt(256),
                        random.nextInt(256),
                        random.nextInt(256),
                        random.nextInt(256));
                    final button = ButtonData(getColor, '✨');
                    final tagData = DynamicTagData(value, button);
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
            child: const Text(
              'CLEAR TAGS',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class DynamicMultilineTags extends StatefulWidget {
  const DynamicMultilineTags({Key? key}) : super(key: key);

  @override
  State<DynamicMultilineTags> createState() => _DynamicMultilineTagsState();
}

class _DynamicMultilineTagsState extends State<DynamicMultilineTags> {
  late double _distanceToField;
  late DynamicTagController<DynamicTagData<ButtonData>> _dynamicTagController;
  final random = Random();

  static final List<DynamicTagData<ButtonData>> _initialTags = [
    DynamicTagData<ButtonData>(
      'cat',
      const ButtonData(
        Color.fromARGB(255, 202, 198, 253),
        "😽",
      ),
    ),
    DynamicTagData(
      'penguin',
      const ButtonData(
        Color.fromARGB(255, 199, 244, 255),
        '🐧',
      ),
    ),
    DynamicTagData(
      'tiger',
      const ButtonData(
        Color.fromARGB(255, 252, 195, 250),
        '🐯',
      ),
    ),
    DynamicTagData<ButtonData>(
      'whale',
      const ButtonData(
        Color.fromARGB(255, 209, 248, 193),
        "🐋",
      ),
    ),
    DynamicTagData(
      'bear',
      const ButtonData(
        Color.fromARGB(255, 254, 237, 199),
        '🐻',
      ),
    ),
    DynamicTagData(
      'lion',
      const ButtonData(
        Color.fromARGB(255, 252, 196, 196),
        '🦁',
      ),
    ),
  ];

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
    _dynamicTagController = DynamicTagController<DynamicTagData<ButtonData>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 74, 137, 92),
        centerTitle: true,
        title: const Text(
          'Dynamic Tag Multiline Demo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            TextFieldTags<DynamicTagData<ButtonData>>(
              textfieldTagsController: _dynamicTagController,
              initialTags: _initialTags,
              textSeparators: const [' ', ','],
              letterCase: LetterCase.normal,
              validator: (DynamicTagData<ButtonData> tag) {
                if (tag.tag == 'lion') {
                  return 'Not envited per tiger request';
                } else if (_dynamicTagController.getTags!
                    .any((element) => element.tag == tag.tag)) {
                  return 'Already in the club';
                }
                return null;
              },
              inputFieldBuilder: (context, inputFieldValues) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    onTap: () {
                      _dynamicTagController.getFocusNode?.requestFocus();
                    },
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
                      helperText: 'Zootopia club...',
                      helperStyle: const TextStyle(
                        color: Color.fromARGB(255, 74, 137, 92),
                      ),
                      hintText: inputFieldValues.tags.isNotEmpty
                          ? ''
                          : "Register name...",
                      errorText: inputFieldValues.error,
                      prefixIconConstraints:
                          BoxConstraints(maxWidth: _distanceToField * 0.8),
                      prefixIcon: inputFieldValues.tags.isNotEmpty
                          ? SingleChildScrollView(
                              controller: inputFieldValues.tagScrollController,
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                  left: 8,
                                ),
                                child: Wrap(
                                    runSpacing: 4.0,
                                    spacing: 4.0,
                                    children: inputFieldValues.tags
                                        .map((DynamicTagData<ButtonData> tag) {
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
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              child: Text(
                                                '${tag.data.emoji} ${tag.tag}',
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0)),
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
                                                    255, 0, 0, 0),
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
                              ),
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
                      final tagData = DynamicTagData(value, button);
                      inputFieldValues.onTagChanged(tagData);
                    },
                    onSubmitted: (value) {
                      final getColor = Color.fromARGB(
                          random.nextInt(256),
                          random.nextInt(256),
                          random.nextInt(256),
                          random.nextInt(256));
                      final button = ButtonData(getColor, '✨');
                      final tagData = DynamicTagData(value, button);
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
              child: const Text(
                'CLEAR TAGS',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicAutoCompleteTags extends StatefulWidget {
  const DynamicAutoCompleteTags({Key? key}) : super(key: key);

  @override
  State<DynamicAutoCompleteTags> createState() =>
      _DynamicAutoCompleteTagsState();
}

class _DynamicAutoCompleteTagsState extends State<DynamicAutoCompleteTags> {
  late double _distanceToField;
  late DynamicTagController<DynamicTagData<ButtonData>> _dynamicTagController;
  final random = Random();

  static final List<DynamicTagData<ButtonData>> _initialTags = [
    DynamicTagData<ButtonData>(
      'cat',
      const ButtonData(
        Color.fromARGB(255, 202, 198, 253),
        "😽",
      ),
    ),
    DynamicTagData(
      'penguin',
      const ButtonData(
        Color.fromARGB(255, 199, 244, 255),
        '🐧',
      ),
    ),
    DynamicTagData(
      'tiger',
      const ButtonData(
        Color.fromARGB(255, 252, 195, 250),
        '🐯',
      ),
    ),
    DynamicTagData<ButtonData>(
      'whale',
      const ButtonData(
        Color.fromARGB(255, 209, 248, 193),
        "🐋",
      ),
    ),
    DynamicTagData<ButtonData>(
      'bear',
      const ButtonData(
        Color.fromARGB(255, 254, 237, 199),
        '🐻',
      ),
    ),
    DynamicTagData(
      'lion',
      const ButtonData(
        Color.fromARGB(255, 252, 196, 196),
        '🦁',
      ),
    ),
  ];

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
    _dynamicTagController = DynamicTagController<DynamicTagData<ButtonData>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 74, 137, 92),
        centerTitle: true,
        title: const Text(
          'Dynamic Tag Autocomplete Demo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Autocomplete<DynamicTagData<ButtonData>>(
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Material(
                    elevation: 4.0,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final DynamicTagData<ButtonData> option =
                              options.elementAt(index);
                          return TextButton(
                            onPressed: () {
                              onSelected(option);
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '#${option.data.emoji}${option.tag}',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 74, 137, 92),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                return TextFieldTags<DynamicTagData<ButtonData>>(
                  textfieldTagsController: _dynamicTagController,
                  textEditingController: textEditingController,
                  focusNode: focusNode,
                  textSeparators: const [' ', ','],
                  letterCase: LetterCase.normal,
                  validator: (DynamicTagData<ButtonData> tag) {
                    if (tag.tag == 'lion') {
                      return 'Not envited per tiger request';
                    } else if (_dynamicTagController.getTags!
                        .any((element) => element.tag == tag.tag)) {
                      return 'Already in the club';
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
                          helperText: 'Zootopia club...',
                          helperStyle: const TextStyle(
                            color: Color.fromARGB(255, 74, 137, 92),
                          ),
                          hintText: inputFieldValues.tags.isNotEmpty
                              ? ''
                              : "Register name...",
                          errorText: inputFieldValues.error,
                          prefixIconConstraints:
                              BoxConstraints(maxWidth: _distanceToField * 0.74),
                          prefixIcon: inputFieldValues.tags.isNotEmpty
                              ? SingleChildScrollView(
                                  controller:
                                      inputFieldValues.tagScrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: inputFieldValues.tags.map(
                                          (DynamicTagData<ButtonData> tag) {
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
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)),
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
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
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
                        onChanged: (value) {
                          final getColor = Color.fromARGB(
                              random.nextInt(256),
                              random.nextInt(256),
                              random.nextInt(256),
                              random.nextInt(256));
                          final button = ButtonData(getColor, '✨');
                          final tagData = DynamicTagData(value, button);
                          inputFieldValues.onTagChanged(tagData);
                        },
                        onSubmitted: (value) {
                          final getColor = Color.fromARGB(
                              random.nextInt(256),
                              random.nextInt(256),
                              random.nextInt(256),
                              random.nextInt(256));
                          final button = ButtonData(getColor, '✨');
                          final tagData = DynamicTagData(value, button);
                          inputFieldValues.onTagSubmitted(tagData);
                        },
                      ),
                    );
                  },
                );
              },
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<DynamicTagData<ButtonData>>.empty();
                }
                return _initialTags.where((DynamicTagData<ButtonData> option) {
                  return option.tag
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (option) {
                _dynamicTagController.onTagSubmitted(option);
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
              child: const Text(
                'CLEAR TAGS',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

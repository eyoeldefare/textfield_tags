import 'package:example/custom_tag_examples.dart';
import 'package:example/dynamic_tag_examples.dart';
import 'package:example/string_tag_examples.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Textfield Tags Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 74, 137, 92),
        centerTitle: true,
        title: const Text(
          'Textfield Tags Demo...',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'STRING TAGS w/ StringTagController',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                    Wrap(
                      spacing: 16.0, // gap between adjacent chips
                      runSpacing: 16.0, // gap between lines
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 74, 137, 92),
                            ),
                          ),
                          onPressed: () {
                            print("Here");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StringTags(),
                              ),
                            );
                          },
                          child: const Text(
                            'STRING TAGS',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 74, 137, 92),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const StringAutoCompleteTags(),
                              ),
                            );
                          },
                          child: const Text(
                            'STRING TAGS w/ AUTOCOMPLETE',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 74, 137, 92),
                            ),
                          ),
                          onPressed: () {
                            //Route to string multiline
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const StringMultilineTags(),
                              ),
                            );
                          },
                          child: const Text(
                            'STRING TAGS w/ MULTILINE',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'DYNAMIC TAGS w/ DynamicTagController',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                    Wrap(
                      spacing: 16.0, // gap between adjacent chips
                      runSpacing: 16.0, // gap between lines
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 74, 137, 92),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DynamicTags(),
                              ),
                            );
                          },
                          child: const Text(
                            'DYNAMIC TAGS',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 74, 137, 92),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DynamicAutoCompleteTags(),
                              ),
                            );
                          },
                          child: const Text(
                            'DYNAMIC TAGS w/ AUTOCOMPLETE',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 74, 137, 92),
                            ),
                          ),
                          onPressed: () {
                            //Route to string multiline
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DynamicMultilineTags(),
                              ),
                            );
                          },
                          child: const Text(
                            'DYNAMIC TAGS w/ MULTILINE',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'CUSTOM TAGS w/ Custom Controllers',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                    Wrap(
                      spacing: 16.0, // gap between adjacent chips
                      runSpacing: 16.0, // gap between lines
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 74, 137, 92),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CustomTags(),
                              ),
                            );
                          },
                          child: const Text(
                            'CUSTOM TAGS',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

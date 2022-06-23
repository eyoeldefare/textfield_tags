# textfield_tags

This widget allows you to create a textfield that takes in Textfield values and display the values as tags. The tags can also be customized to your own preference. The widget also takes in a controller that can also be customized by extending it into your own custom controller and inheriting its functionalities.  

## Environment

`sdk: ">=2.12.0 <3.0.0"`

`flutter: ">=1.17.0"`

## Installation

```yaml 
  dependencies:
      textfield_tags: ^2.0.1
```

`$ flutter pub get`

## Getting Started

To start using this widget, you will need to first import the package inside your project following the installation guide found on [Flutter.dev](https://pub.dev/packages/textfield_tags).

## Usage

To use this widget, 
1. `import 'package:textfield_tags/textfield_tags.dart';` inside your dart file
2. Call the widget `TextFieldTags()`. 
3. The widget takes in 8 arguments: `List<String>? initialTags`, `FocusNode? focusNode`, `TextEditingController? textEditingController`, `List<String>? textSeperators`, `LetterCase? letterCase`, `Validator? validator`, `InputFieldBuilder inputfieldBuilder`, `TextfieldTagsController? textfieldController`. Read the api documentation about these properties for more details.

### When you want to use it, call the `TextFieldTags()` as bellow examples show

``` dart 
class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _distanceToField;
  TextfieldTagsController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "wellcome",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 74, 137, 92),
          centerTitle: true,
          title: const Text('Enter a tag...'),
        ),
        body: Column(
          children: [
            TextFieldTags(
              textfieldTagsController: _controller,
              initialTags: const [
                'pick',
                'your',
                'favorite',
                'programming',
                'language'
              ],
              textSeparators: const [' ', ','],
              letterCase: LetterCase.normal,
              validator: (String tag) {
                if (tag == 'php') {
                  return 'No, please just no';
                } else if (_controller.getTags.contains(tag)) {
                  return 'you already entered that';
                }
                return null;
              },
              inputfieldBuilder:
                  (context, tec, fn, error, onChanged, onSubmitted) {
                return ((context, sc, tags, onTagDelete) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: tec,
                      focusNode: fn,
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
                        hintText: _controller.hasTags ? '' : "Enter tag...",
                        errorText: error,
                        prefixIconConstraints:
                            BoxConstraints(maxWidth: _distanceToField * 0.74),
                        prefixIcon: tags.isNotEmpty
                            ? SingleChildScrollView(
                                controller: sc,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    children: tags.map((String tag) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                      color: Color.fromARGB(255, 74, 137, 92),
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
                                            '#$tag',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          onTap: () {
                                            print("$tag selected");
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
                                            onTagDelete(tag);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                }).toList()),
                              )
                            : null,
                      ),
                      onChanged: onChanged,
                      onSubmitted: onSubmitted,
                    ),
                  );
                });
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 74, 137, 92),
                ),
              ),
              onPressed: () {
                _controller.clearTags();
              },
              child: const Text('CLEAR TAGS'),
            ),
          ],
        ),
      ),
    );
  }
}
```
## V2.0.0+ Examples

Please note that versions bellow V2.0.0 will not be supported anymore. Please consider upgrading to V2.0.0+. 
The new changes offer more customization and flexibility to developers with many functionalities that solves previous customization issues related to this package. Now you can design this Widget to whatever you wants it. All the functionalities from previous versions are also included.

Sample examples will be shown bellow from left to right respectively.

[Example 1](https://github.com/eyoeldefare/textfield_tags/blob/master/example/lib/main1.dart)

[Example 2](https://github.com/eyoeldefare/textfield_tags/blob/master/example/lib/main.dart)

### Visual Samples For Above Examples

<img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/gif_1.gif" width=250> <img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/gif_2.gif" width=250>

## More Advanced Functionality Via Custom Controller

If you feel like you want more functionality than what is offered from the default controller that comes with this widget, you can easily extend the controller's class to your own custom class and inherit all its functionality and add your own stuffs as bellow example shows.

### Example:

``` dart
  // Create my own custom controller
  class MyCustomController extends TextfieldTagsController {
      MyCustomController() : super();

      //create your own methods
      void myCustomMethod(){
      }
     
      //override the super class method
      @override
        set addTag(String tag) {
          if(tag!='php'){
            super.addTag = tag;
            notifyListeners();
          }else{
            _error= '?';
          }
      }
      
      //....
 }

  final _myCustomController = MyCustomController();
  TextFieldTags(textfieldController: _myCustomController);
```
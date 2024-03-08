# textfield_tags

Textfield tags is a widget allows you to create tags inside a textfield. The tags can be customized to your own preferences as the widget allows you to create your own tags. The default controllers allow you to store tags as regular strings or `TagData` object which allows you to store any kinds of data. This allow you to store color themes with each tags and display those based on the tag entered.  

## Environment

`sdk: ">=2.12.0 <4.0.0"`

`flutter: ">=1.17.0"`

## Installation

```yaml 
  dependencies:
      textfield_tags: ^2.1.1
```

`$ flutter pub get`

## Getting Started

To start using this widget, you will need to first import the package inside your project following the installation guide found on [Flutter.dev](https://pub.dev/packages/textfield_tags).

## Usage

To use this widget, 
1. `import 'package:textfield_tags/textfield_tags.dart';` inside your dart file
2. Follow the example bellow to call the widget `TextFieldTags(...)`. 
3. The widget takes in 9 arguments: `List<String>? initialTags`, 
`ScrollController? scrollController`,
`FocusNode? focusNode`, 
`TextEditingController? textEditingController`, `List<String>? textSeperators`, 
`LetterCase? letterCase`, 
`Validator? validator`, 
`InputFieldBuilder inputfieldBuilder`, `TextfieldTagsController? textfieldController`. Read the api documentation about these properties for more details or see the examples provided in example folder.

## Controller support
By default, this widget comes with 2 built-in controllers: one that allows you to manage string based tags and another one that allows you to store other data with the tags. We will do deeper in each types of controllers bellow.

### Storing `String` Tags
If you want to store and manage your tags in a simple `String` type, then this example will be enough for your solution. 

This solution uses `StringTagControlle<String>()` controller to manage the tags.

``` dart
  class MyWidget extends StatelessWidget {
    const MyWidget({Key? key}) : super(key: key);

    final _stringTagController = StringTagControlle();

    @override
    Widget build(BuildContext context) {
      return TextFieldTags<String>(
        textfieldTagsController: _stringTagController,
        initialTags:['cat','dog'],
        textSeparators: const [' ', ','],
        validator: (String tag){
          if (tag == 'lion'){
            return 'Lion not allowed';
          }
          return null;
        },
        inputFieldBuilder: (context, inputFieldValues){
          return TextField();
        }
      );
    }
  }

```
### Storing objects with string Tags
If you want to store other objects along with the string tags this solution will be ideal for you. Storing other objects allows you to design the tags based on their stored data or consume the stored data for other reasons. 

This solution uses `DynamicTagController<TagData<YourDataType>>()` controller to manage the tags. In this case, `YourDataType` is the data you want to use such as int, String, Object, etc.

``` dart 
class ButtonColor{
  final Color buttonColor;
  final Color buttonTextColor;
  const ButtonColor(this.buttonColor, this.buttonTextColor);
}

class MyWidget extends StatelessWidget {
    const MyWidget({Key? key}) : super(key: key);
    final _dynamicTagController = DynamicTagController<TagData<ButtonColor>>()

    @override
    Widget build(BuildContext context) {
      return TextFieldTags<TagData<ButtonColor>>(
        textfieldTagsController: _dynamicTagController,
        initialTags:[
          TagData(
            'cat',
            ButtonColor(
              Color.fromARGB(255, 74, 137, 92),
              Color.fromARGB(255, 137, 74, 126),
            ),
          ),
          TagData(
            'dog',
            ButtonColor(
              Color.fromARGB(123, 74, 137, 92),
              Color.fromARGB(45, 137, 74, 126),
            ),
          ),
        ],
        textSeparators: const [' ', ','],
        validator: (TagData<ButtonColor> tag){
          if (tag == 'lion'){
            return 'Lion not allowed';
          }
          return null;
        },
        inputFieldBuilder: (context, inputFieldValues){
          return TextField();
        }
      ); 
    }
  }
```

### Examples
Sample examples will be shown bellow from left to right respectively.

[Example 1](https://github.com/eyoeldefare/textfield_tags/blob/master/example/lib/main1.dart)

[Example 2](https://github.com/eyoeldefare/textfield_tags/blob/master/example/lib/main.dart)

[Example 3 Multiline](https://github.com/eyoeldefare/textfield_tags/blob/master/example/lib/main2.dart)

[Example 4 Custom Controller](https://github.com/eyoeldefare/textfield_tags/blob/master/example/lib/main3.dart)

## Visual Samples For The Above Examples

<img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/gif_1.gif" width=250> <img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/gif_2.gif" width=250>  <img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/gif_3.gif" width=250>

### More Advanced Functionality Via Your Own Custom Controller

If you feel like you want more functionality than what is offered by the 2 default controllers, you can easily extend `TextfieldTagsController` class to your own custom class and inherit all its functionalities and add your own stuffs as bellow example show.

The bellow example shows you how you can use a numbers
tag picker that selects numbers between 2 and 10 with the exception of number 8.

## Example:

``` dart
  // Create my own custom controller
  class MyIntTagController<T extends int> extends TextfieldTagsController<T> {
      @override
      bool? onTagSubmitted(T value) {
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
            setError = 'Must enter numbers between 2 and 10';
          }
          return null;
      }

      @override
      set setError(String? error) {
        super.setError = error;
        notifyListeners();
      }

      doOtherThings(){
        ...
      }
  }

  class MyWidget extends StatelessWidget {
    const MyWidget({Key? key}) : super(key: key);
    final _myintTagController = MyIntTagController<int>();

    @override
    Widget build(BuildContext context) {
      return TextFieldTags<int>(
        textfieldTagsController: _myintTagController,
        initialTags:[ 4, 5 ],
        validator: (int tag){
          if (tag == 8){
            return '8 is not allowed';
          }
          return null;
        },
        inputFieldBuilder: (context, inputFieldValues){
          return TextField();
        }
      ); 
    }
  }
```

[See Example](https://github.com/eyoeldefare/textfield_tags/blob/master/example/lib/main3.dart)
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
2. Follow one of the examples bellow and call the widget `TextFieldTags(...)`. 
3. The widget takes in 9 arguments: 
`List<String>? initialTags`, 
`ScrollController? scrollController`,
`FocusNode? focusNode`, 
`TextEditingController? textEditingController`, `List<String>? textSeperators`, 
`LetterCase? letterCase`, 
`Validator? validator`, 
`InputFieldBuilder inputfieldBuilder`, `TextfieldTagsController? textfieldController`. Read the api documentation on these properties for more details or see the examples provided in the example folder.

## Examples With Different Controllers
By default, the widget comes with 2 built-in controllers: one that allows you to manage string based tags and another one that allows you to store other data with the tags. We will show examples of controller usage bellow.

### Using `String` based tags (`StringTagControlle`)
If you only want to use string based tags, then the `StringTagControlle` is good enough for you. The example bellow shows how you can utilize the `StringTagControlle<String>()` controller to manage the tags.

[See Full Example](https://github.com/eyoeldefare/textfield_tags/blob/master/example/lib/main1.dart)

``` dart
  class MyWidget extends StatelessWidget {
    const MyWidget({Key? key}) : super(key: key);

    final _stringTagController = StringTagControlle();

    @override
    Widget build(BuildContext context) {
      return TextFieldTags<String>(
        textfieldTagsController: _stringTagController,
        initialTags:['python','java'],
        textSeparators: const [' ', ','],
        validator: (String tag){
          if (tag == 'php'){
            return 'Php not allowed';
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
<img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/gif_1.gif" width=250>

### Using dynamic based tags (`DynamicTagController`)
If you want to store other datas with each tags, then this solution will be ideal for you. This will offer you more flexibiliity and customization as storing other datas  will allow you to design the tags based on their own stored data. 

For example the bellow example stores the colors of each tags to show their color. We will store the button color and text color of each tags.

[See Full Example](https://github.com/eyoeldefare/textfield_tags/blob/master/example/lib/main1.dart)

``` dart 
//Sample data model 
class ButtonData {
  final Color buttonColor;
  final String emoji;
  const ButtonData(this.buttonColor, this.emoji);
}

class MyWidget extends StatelessWidget {
    const MyWidget({Key? key}) : super(key: key);
    final _dynamicTagController = DynamicTagController<TagData<ButtonData>>()

    @override
    Widget build(BuildContext context) {
      return TextFieldTags<TagData<ButtonData>>(
        textfieldTagsController: _dynamicTagController,
        initialTags:[
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
        validator: (TagData<ButtonData> tag){
          if (tag.tag == 'lion') {
            return 'Not envited per tiger request';
          } else if (_dynamicTagController.getTags!
              .any((element) => element.tag == tag.tag)) {
            return 'Already in the club';
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
<img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/gif_2.gif" width=250>

### More Advanced Functionality Via A Custom Controller

If you feel like you want more functionality than what is offered by the 2 default controllers, you can easily extend `TextfieldTagsController` class to your own custom class and inherit all its functionalities and add your own stuffs as bellow example show.

The bellow example shows you how you can use a numbers
tag picker that selects numbers between 2 and 10 with the exception of number 8.

[See Full Example](https://github.com/eyoeldefare/textfield_tags/blob/master/example/lib/main1.dart)(_this example also shows multiline functionality_)

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
<img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/gif_3.gif" width=250> <img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/gif_3.gif" width=250>

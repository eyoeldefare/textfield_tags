# textfield_tags

This is a simple widget that allows your users to create tags by entering the tag's name inside of textfield and make the tags appear in the textfield. After entering the tag, the user can press the spacebar or enter button to save the tag
and move on to enter another tag.

## Compatibility

`sdk: ">=2.7.0 <3.0.0"`

`flutter: ">=1.17.0 <2.0.0"`

## Getting Started

To start using this widget, you will need to first import the package inside your project following the install guide found on [Flutter.dev](https://flutter.dev).

## Usage

To use this widget, 
1. `import 'package:textfield_tags/textfield_tags.dart';` inside your dart file
2. Call the widget `TextFieldTags()`. 
3. The widget takes in three arguments: `TagsStyler`, `TextFieldStyler`, and a call back function that returns the tags your user enters.
You can investigate the properties of `TagsStyler` and `TextFieldStyler` for more customizations if you choose to do so.

### When you want to use it, call the `TextFieldTags()` widget as bellow and customize it to your liking

``` dart 
   TextFieldTags(
      tags: <String>[
         // List of tags
         // Provide a list of tags to initialize it with a list your provided tags
         ],
      textFieldStyler: TextFieldStyler(
          //These are properties you can tweek for customization

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
          // OutlineInputBorder textFieldEnabledBorder
          ),
      tagsStyler: TagsStyler(
          //These are properties you can tweek for customization

          // EdgeInsets tagPadding = const EdgeInsets.all(4.0),
          // EdgeInsets tagMargin = const EdgeInsets.symmetric(horizontal: 4.0),
          // BoxDecoration tagDecoration = const BoxDecoration(color: Color.fromARGB(255, 74, 137, 92)),
          // TextStyle tagTextStyle,
          // Icon tagCancelIcon = const Icon(Icons.cancel, size: 18.0, color: Colors.green)
          ),
      onTag: (tag) {
        //This give you the tag entered
        
        //print(tag)
      },
    )
```

## Examples

``` dart
  TextFieldTags(
      tags: ['university', 'college', 'music', 'math'],
      tagsStyler: TagsStyler(
        tagTextStyle: TextStyle(fontWeight: FontWeight.bold),
        tagDecoration: BoxDecoration(color: Colors.blue[300], borderRadius: BorderRadius.circular(8.0), ),
        tagCancelIcon: Icon(Icons.cancel, size: 18.0, color: Colors.blue[900]),
        tagPadding: const EdgeInsets.all(6.0)
     ),
   )
```
<img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/i1.png" width="350">

``` dart
  TextFieldTags(
      tagsStyler: TagsStyler(
        tagTextStyle: TextStyle(fontWeight: FontWeight.normal),
        tagDecoration: BoxDecoration(color: Colors.blue[300], borderRadius: BorderRadius.circular(0.0), ),
        tagCancelIcon: Icon(Icons.cancel, size: 18.0, color: Colors.blue[900]),
        tagPadding: const EdgeInsets.all(6.0)
     ),
     onTag: (tag) { print(tag)},  
   )
```
<img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/i2.png" width="350">

``` dart
  //The Colors for this are used from https://flutter-color-picker.herokuapp.com/
  TextFieldTags(
      tagsStyler: TagsStyler(
        tagTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), 
        tagDecoration: BoxDecoration(color: const Color.fromARGB(255,171,81,81), borderRadius: BorderRadius.circular(8.0), ),
        tagCancelIcon: Icon(Icons.cancel, size: 16.0, color: Color.fromARGB(255,235,214,214)),
        tagPadding: const EdgeInsets.all(10.0),
     ),
     onTag: (tag) { print(tag)},  
   )
```
<img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/i3.png" width="350">


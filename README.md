# textfield_tags

This is a widget that allows your users to create tags by entering the tag's name inside of textfield and make the tags appear in the textfield. After entering the tag, the user can press the spacebar or enter button to save the tag
and move on to enter another tag.

## Environment

`sdk: ">=2.12.0 <3.0.0"`

`flutter: ">=1.17.0"`

## Installation

```yaml 
  dependencies:
      textfield_tags: ^1.4.1
```

`$ flutter pub get`


## Getting Started

To start using this widget, you will need to first import the package inside your project following the installation guide found on [Flutter.dev](https://flutter.dev).

## Usage

To use this widget, 
1. `import 'package:textfield_tags/textfield_tags.dart';` inside your dart file
2. Call the widget `TextFieldTags()`. 
3. The widget takes in 5 arguments: `TagsStyler`, `TextFieldStyler`, `onTag`, `onDelete`, and `initialTags`. Note that `TagsStyler`, `TextFieldStyler`, `onTag`, `onDelete` should not be null.
You can investigate the properties of `TagsStyler` and `TextFieldStyler` for more customizations if you choose to do so.

### When you want to use it, call the `TextFieldTags()` as bellow examples show

``` dart 
   TextFieldTags(
     textSeparators: <String> [
       //text tag seperators
       //Default = " ", ","
     ],
      tags: <String>[
         // List of tags
         // Provide a list of initial tags to initialize it
      ],
      textFieldStyler: TextFieldStyler(
          //These are properties you can tweek for customization

          // bool textFieldFilled = false,
          // Icon icon,
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
          
          // showHashtag = false,
          // EdgeInsets tagPadding = const EdgeInsets.all(4.0),
          // EdgeInsets tagMargin = const EdgeInsets.symmetric(horizontal: 4.0),
          // BoxDecoration tagDecoration = const BoxDecoration(color: Color.fromARGB(255, 74, 137, 92)),
          // TextStyle tagTextStyle,
          // Icon tagCancelIcon = const Icon(Icons.cancel, size: 18.0, color: Colors.green)
          ),
      onTag: (tag) {
        //This give you the tag that was entered
        //print(tag)
      },

      onDelete: (tag){
        //This gives you the tag that was deleted
        //print(tag)
      },
      validator: (tag){
        if(tag.length>15){
          return "hey that's too long";
        }
        return null;
      }
      //tagsDistanceFromBorderEnd: 0.725,
      //scrollableTagsMargin: EdgeInsets.only(left: 9),
      //scrollableTagsPadding: EdgeInsets.only(left: 9),
    )
```
## Example giffs

<img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/g1.gif" width="300">
<img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/g2.gif" width="300">
<img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/g3.gif" width="300">

## Examples pics

``` dart
  TextFieldTags(
      tagsStyler: TagsStyler(
        tagTextStyle: TextStyle(fontWeight: FontWeight.normal),
        tagDecoration: BoxDecoration(color: Colors.blue[300], borderRadius: BorderRadius.circular(0.0), ),
        tagCancelIcon: Icon(Icons.cancel, size: 18.0, color: Colors.blue[900]),
        tagPadding: const EdgeInsets.all(6.0)
      ),
      textFieldStyler: TextFieldStyler(),
      onTag: (tag) {},
      onDelete: (tag) {},
      validator: (tag){
        if(tag.length>15){
          return "hey that's too long";
        }
        return null;
      } 
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
      textFieldStyler: TextFieldStyler(),
      onTag: (tag) {},
      onDelete: (tag) {},
      validator: (tag){
        if(tag.length>15){
          return "hey that's too long";
        }
        return null;
      }
   )
```
<img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/i3.png" width="350">


``` dart
TextFieldTags(
  initialTags: ["college"],
  tagsStyler: TagsStyler(
    showHashtag: true,
    tagMargin: const EdgeInsets.only(right: 4.0),
    tagCancelIcon: Icon(Icons.cancel, size: 15.0, color: Colors.black),
    tagCancelIconPadding: EdgeInsets.only(left: 4.0, top: 2.0),
    tagPadding:
        EdgeInsets.only(top: 2.0, bottom: 4.0, left: 8.0, right: 4.0),
    tagDecoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.grey.shade300,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(20.0),
      ),
    ),
    tagTextStyle:
        TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
  ),
  textFieldStyler: TextFieldStyler(
    hintText: "Tags",
    isDense: false,
    textFieldFocusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 3.0),
    ),
    textFieldBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 3.0),
    ),
  ),
  onDelete: (tag) {
    print('onDelete: $tag');
  },
  onTag: (tag) {
    print('onTag: $tag');
  },
  validator: (String tag) {
    print('validator: $tag');
    if (tag.length > 10) {
      return "hey that is too much";
    }
    return null;
  },
)
```
<img src="https://raw.githubusercontent.com/eyoeldefare/textfield_tags/master/images/i4.png" width="350">
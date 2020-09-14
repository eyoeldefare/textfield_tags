//Models
import 'package:flutter/material.dart';

///[TagsStyler] is a model class that allows you to design the exact style you want from your tag by using its properties

class TagsStyler {
  ///[tagPadding] allows you to apply padding inside tag
  final EdgeInsets tagPadding;

  ///[tagMargin] allows you to apply padding inside tag
  final EdgeInsets tagMargin;

  ///[tagMargin] apply decoration to the container containing the tag
  final BoxDecoration tagDecoration;

  ///[tagTextStyle] style the text inside tag
  final TextStyle tagTextStyle;

  ///[tagCancelIcon] apply your own icon, if you want, to delete the icon
  final Icon tagCancelIcon;

  TagsStyler({
    this.tagPadding = const EdgeInsets.all(4.0),
    this.tagMargin = const EdgeInsets.symmetric(horizontal: 4.0),
    this.tagDecoration =
    const BoxDecoration(color: Color.fromARGB(255, 74, 137, 92)),
    this.tagTextStyle,
    this.tagCancelIcon = const Icon(
      Icons.cancel,
      size: 18.0,
      color: Colors.green,
    ),
  });
}

///[TextFieldStyler] is a model class that allows you to design the exact style you want from your textfield by using its properties
class TextFieldStyler {
  /// The color of the decoration inside the textfield
  final Color textFieldFilledColor;

  ///[textFieldFilled] If true the decoration's container is filled with [textFieldFilledColor].
  final bool textFieldFilled;

  ///The padding for the input decoration's container. Adjust this to using EdgeInsets if you make textFieldBorder [null] or borderless to have the right customized style
  final EdgeInsets contentPadding;

  ///Whether the input [child] is part of a dense form (i.e., uses less vertical space).
  final bool isDense;

  ///Text that provides context about the input [child]'s value, such as how the value will be used.
  final String helperText;

  ///Style helperText
  final TextStyle helperStyle;

  ///Text that suggests what sort of input the field accepts.
  final String hintText;

  ///Styles hint text
  final TextStyle hintStyle;

  ///Enable or disable the textfield
  final bool textFieldEnabled;

  ///If you make the textFieldBorder [null],
  ///adjust the [contentPadding] to get the correct styling
  final OutlineInputBorder textFieldBorder;
  final OutlineInputBorder textFieldFocusedBorder;
  final OutlineInputBorder textFieldDisabledBorder;
  final OutlineInputBorder textFieldEnabledBorder;

  TextFieldStyler({
    this.textFieldFilled = false,
    this.helperText = 'Enter tags',
    this.helperStyle,
    this.hintText = 'Got tags?',
    this.hintStyle,
    this.contentPadding,
    this.textFieldFilledColor,
    this.isDense = true,
    this.textFieldEnabled = true,
    this.textFieldBorder = const OutlineInputBorder(),
    this.textFieldFocusedBorder,
    this.textFieldDisabledBorder,
    this.textFieldEnabledBorder,
  });
}

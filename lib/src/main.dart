import 'package:flutter/material.dart';
import 'controller.dart';

class TextFieldTags<T> extends StatefulWidget {
  ///[validator] allows you to validate the tag that has been entered
  final Validator<T>? validator;

  ///[initialTags] are optional initial tags that show up on the text field. Default is set to empty list.
  final List<T>? initialTags;

  ///Enter optional String separators to split the tags. Default is set to [","," "]
  final List<String>? textSeparators;

  ///Change the letter case of the text entered by user. Default is set to normal letter[LetterCase.normal]
  final LetterCase? letterCase;

  ///Use this to utilize your own [TextEditingController] instance created by you or by other widgets outside of this widget.
  ///If no controller is provider by you, the widget will use its own built in default controller.
  final TextEditingController? textEditingController;

  ///Use this to utilize your own [FocusNode] instance created by you or by other widgets outside of this widget.
  ///If no focus node is provider by you, the widget will use its own built in default one.
  final FocusNode? focusNode;

  ///Use this to utilize your own [ScrollController] instance created by you or by other widgets outside of this widget.
  ///If no scroll controller is provider, the widget will use a default one.
  final ScrollController? scrollController;

  ///This [InputFieldBuilder] allows you to build your own custom widget
  ///Note that this field is required
  final InputFieldBuilder<T> inputFieldBuilder;

  ///[TextfieldTagsController] is the controller that houses the control for tags, textfield properties and other properties.
  ///Note that this field is required to be initialized in your class
  ///and must have the same type as the [TextFieldTags] widget
  final TextfieldTagsController<T> textfieldTagsController;

  const TextFieldTags({
    Key? key,
    this.validator,
    this.initialTags,
    this.textSeparators,
    this.letterCase,
    this.textEditingController,
    this.focusNode,
    this.scrollController,
    required this.textfieldTagsController,
    required this.inputFieldBuilder,
  }) : super(key: key);

  @override
  createState() => _TextFieldTagsState<T>();
}

class _TextFieldTagsState<T> extends State<TextFieldTags<T>> {
  late TextfieldTagsController<T> _ttc;
  late InputFieldValues<T> _ttv;

  @override
  void initState() {
    super.initState();
    _ttc = widget.textfieldTagsController
      ..registerController(
        widget.initialTags,
        widget.textSeparators,
        widget.letterCase,
        widget.validator,
        widget.focusNode,
        widget.textEditingController,
        widget.scrollController,
      )
      ..scrollTags();

    _ttv = InputFieldValues(
      onTagChanged: _ttc.onTagChanged,
      onTagSubmitted: _ttc.onTagSubmitted,
      onTagRemoved: _ttc.onTagRemoved,
      tags: _ttc.getTags!,
      error: _ttc.getError,
      tagScrollController: _ttc.getScrollController!,
      textEditingController: _ttc.getTextEditingController!,
      focusNode: _ttc.getFocusNode!,
    );

    _ttc.addListener(() {
      if (mounted) {
        setState(() {
          _ttv.error = _ttc.getError;
          _ttv.tags = _ttc.getTags!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final build = widget.inputFieldBuilder(
      context,
      _ttv,
    );
    return build;
  }
}

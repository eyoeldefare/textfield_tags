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

  ///Use this to add more customization and control over the tags and textfield
  final TextfieldTagsController<T>? textfieldTagsController;

  ///This [InputFieldBuilder] allows you to build your own custom widget
  // final InputFieldBuilder? inputFieldBuilder;
  final InputFieldBuilder<T> inputFieldBuilder;

  ///Use this to utilize your own [TextEditingController] instance created by you or by other widgets outside of this widget.
  ///If no controller is provider by you, the widget will use its own built in default controller.
  final TextEditingController? textEditingController;

  ///Use this to utilize your own [FocusNode] instance created by you or by other widgets outside of this widget.
  ///If no focus node is provider by you, the widget will use its own built in default one.
  final FocusNode? focusNode;

  ///Use this to utilize your own [ScrollController] instance created by you or by other widgets outside of this widget.
  ///If no scroll controller is provider, the widget will use a default one.
  final ScrollController? scrollController;

  const TextFieldTags({
    Key? key,
    this.validator,
    this.initialTags,
    this.textSeparators,
    this.letterCase,
    this.textfieldTagsController,
    this.textEditingController,
    this.focusNode,
    this.scrollController,
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
    if (widget.textfieldTagsController != null) {
      _ttc = widget.textfieldTagsController!;
      _ttc.registerController(
        widget.initialTags,
        widget.textSeparators,
        widget.letterCase,
        widget.validator,
        widget.focusNode,
        widget.textEditingController,
        widget.scrollController,
      );
    } else {
      _ttc = TextfieldTagsController.icr(
        widget.initialTags,
        widget.textSeparators,
        widget.validator,
        widget.letterCase,
        widget.focusNode,
        widget.textEditingController,
        widget.scrollController,
      );
    }
    _ttv = InputFieldValues(
      onChanged: _ttc.onChanged,
      onSubmitted: _ttc.onSubmitted,
      onTagDelete: _ttc.onTagDelete,
      tags: _ttc.getTags!,
      error: _ttc.getError,
      tagScrollController: _ttc.getScrollController!,
      textEditingController: _ttc.getTextEditingController!,
      focusNode: _ttc.getFocusNode!,
    );
    _ttc.scrollTags();
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

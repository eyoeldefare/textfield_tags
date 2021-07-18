import 'package:flutter/material.dart';

import 'models.dart';

typedef String? Validator(String? tag);

class TextFieldTags extends StatefulWidget {
  ///[tagsStyler] must not be [null]
  final TagsStyler tagsStyler;

  ///[textFieldStyler] must not be [null]
  final TextFieldStyler textFieldStyler;

  ///[onTag] must not be [null] and should be implemented
  final void Function(String tag) onTag;

  ///[onDelete] must not be [null]
  final void Function(String tag) onDelete;

  ///[validator] allows you to validate the tag that has been entered
  final Validator? validator;

  ///[initialTags] are optional initial tags you can enter
  final List<String>? initialTags;

  ///Padding for the scrollable
  final EdgeInsets scrollableTagsPadding;

  ///Margin for the scrollable
  final EdgeInsets? scrollableTagsMargin;

  ///[tagsDistanceFromBorder] sets the distance of the tags from the border
  final double tagsDistanceFromBorderEnd;

  const TextFieldTags({
    Key? key,
    this.tagsDistanceFromBorderEnd = 0.725,
    this.scrollableTagsPadding = const EdgeInsets.symmetric(horizontal: 4.0),
    this.scrollableTagsMargin,
    this.validator,
    this.initialTags,
    required this.tagsStyler,
    required this.textFieldStyler,
    required this.onTag,
    required this.onDelete,
  }) : super(key: key);

  @override
  _TextFieldTagsState createState() => _TextFieldTagsState();
}

class _TextFieldTagsState extends State<TextFieldTags> {
  List<String>? _tagsStringContents;
  TextEditingController? _textEditingController;
  ScrollController? _scrollController;
  late bool _showPrefixIcon;
  late double _deviceWidth;
  late bool _showValidator;
  late String _validatorMessage;

  @override
  void initState() {
    super.initState();
    _showValidator = false;
    _showPrefixIcon = false;
    _tagsStringContents = [];

    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    if (widget.initialTags != null && widget.initialTags!.isNotEmpty) {
      _showPrefixIcon = true;
      _tagsStringContents = widget.initialTags;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _deviceWidth = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController!.dispose();
    _scrollController!.dispose();
    _tagsStringContents = null;
    _textEditingController = null;
    _scrollController = null;
  }

  List<Widget> get _getTags {
    List<Widget> _tags = [];
    for (var i = 0; i < _tagsStringContents!.length; i++) {
      final String stringContent = _tagsStringContents![i];
      final String stringContentWithHash =
          widget.tagsStyler.showHashtag ? "#$stringContent" : stringContent;
      final Container tag = Container(
        padding: widget.tagsStyler.tagPadding,
        decoration: widget.tagsStyler.tagDecoration,
        margin: widget.tagsStyler.tagMargin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: widget.tagsStyler.tagTextPadding,
              child: Text(
                stringContentWithHash,
                style: widget.tagsStyler.tagTextStyle,
              ),
            ),
            Padding(
              padding: widget.tagsStyler.tagCancelIconPadding,
              child: GestureDetector(
                onTap: () {
                  widget.onDelete(stringContent);
                  if (_tagsStringContents!.length == 1 && _showPrefixIcon) {
                    setState(() {
                      _tagsStringContents!.remove(stringContent);
                      _showPrefixIcon = false;
                      _showValidator = false;
                    });
                  } else {
                    setState(() {
                      _tagsStringContents!.remove(stringContent);
                      _showValidator = false;
                    });
                  }
                },
                child: widget.tagsStyler.tagCancelIcon,
              ),
            ),
          ],
        ),
      );
      _tags.add(tag);
    }
    return _tags;
  }

  void _animateTransition() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_scrollController!.hasClients) {
        _scrollController!.animateTo(
          _scrollController!.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      autocorrect: false,
      cursorColor: widget.textFieldStyler.cursorColor,
      style: widget.textFieldStyler.textStyle,
      decoration: InputDecoration(
        icon: widget.textFieldStyler.icon,
        contentPadding: widget.textFieldStyler.contentPadding,
        isDense: widget.textFieldStyler.isDense,
        helperText: _showValidator
            ? _validatorMessage
            : widget.textFieldStyler.helperText,
        helperStyle: _showValidator
            ? const TextStyle(color: Colors.red)
            : widget.textFieldStyler.helperStyle,
        hintText: !_showPrefixIcon ? widget.textFieldStyler.hintText : null,
        hintStyle: !_showPrefixIcon ? widget.textFieldStyler.hintStyle : null,
        filled: widget.textFieldStyler.textFieldFilled,
        fillColor: widget.textFieldStyler.textFieldFilledColor,
        enabled: widget.textFieldStyler.textFieldEnabled,
        border: widget.textFieldStyler.textFieldBorder,
        focusedBorder: widget.textFieldStyler.textFieldFocusedBorder,
        disabledBorder: widget.textFieldStyler.textFieldDisabledBorder,
        enabledBorder: widget.textFieldStyler.textFieldEnabledBorder,
        prefixIcon: _showPrefixIcon
            ? ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: _deviceWidth * widget.tagsDistanceFromBorderEnd),
                child: Container(
                  margin: widget.scrollableTagsMargin,
                  padding: widget.scrollableTagsPadding,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getTags,
                    ),
                  ),
                ),
              )
            : null,
      ),
      onSubmitted: (value) {
        if (_showValidator == false) {
          final String val = value.trim().toLowerCase();
          if (value.length > 0) {
            _textEditingController!.clear();
            if (!_tagsStringContents!.contains(val)) {
              if (widget.validator == null || widget.validator!(val) == null) {
                widget.onTag(val);
                if (!_showPrefixIcon) {
                  setState(() {
                    _tagsStringContents!.add(val);
                    _showPrefixIcon = true;
                  });
                } else {
                  setState(() {
                    _tagsStringContents!.add(val);
                  });
                }
                this._animateTransition();
              } else {
                setState(() {
                  _showValidator = true;
                  _validatorMessage = widget.validator!(val)!;
                });
              }
            }
          }
        } else {
          setState(() {
            _showValidator = false;
          });
        }
      },
      onChanged: (value) {
        if (_showValidator == false) {
          if (value.contains(" ") || value.contains(",")) {
            final List<String> splitedTagsList = value.multiSplit([",", " "]);
            final int indexer = splitedTagsList.length > 1
                ? splitedTagsList.length - 2
                : splitedTagsList.length - 1;
            final String lastLastTag =
                splitedTagsList[indexer].trim().toLowerCase();
            if (lastLastTag.length > 0) {
              _textEditingController!.clear();
              if (!_tagsStringContents!.contains(lastLastTag)) {
                if (widget.validator == null ||
                    widget.validator!(lastLastTag) == null) {
                  widget.onTag(lastLastTag);
                  if (!_showPrefixIcon) {
                    setState(() {
                      _tagsStringContents!.add(lastLastTag);
                      _showPrefixIcon = true;
                    });
                  } else {
                    setState(() {
                      _tagsStringContents!.add(lastLastTag);
                    });
                  }
                  this._animateTransition();
                } else {
                  setState(() {
                    _showValidator = true;
                    _validatorMessage = widget.validator!(lastLastTag)!;
                  });
                }
              }
            }
          }
        } else {
          setState(() {
            _showValidator = false;
          });
        }
      },
    );
  }
}

extension _Extension on String {
  List<String> multiSplit(List<String> delimenters) {
    return delimenters.isEmpty
        ? [this]
        : this.split(RegExp(delimenters.map(RegExp.escape).join('|')));
  }
}

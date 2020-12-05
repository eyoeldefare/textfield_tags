import 'package:flutter/material.dart';

import 'models.dart';

class TextFieldTags extends StatefulWidget {
  final TagsStyler tagsStyler;
  final TextFieldStyler textFieldStyler;
  final void Function(String tag) onTag;
  final void Function(String tag) onDelete;
  final List<String> tags;

  const TextFieldTags({
    Key key,
    @required this.tagsStyler,
    @required this.textFieldStyler,
    this.onTag,
    this.onDelete,
    this.tags,
  })  : assert(tagsStyler != null || textFieldStyler != null),
        assert((tags == null || tags.length == 0) || (onDelete == null && onTag == null)),
        super(key: key);

  @override
  _TextFieldTagsState createState() => _TextFieldTagsState();
}

class _TextFieldTagsState extends State<TextFieldTags> {
  List<String> _tagsStringContent = [];
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  TagsStyler _tagsStyler;
  TextFieldStyler _textFieldStyler;
  bool _showPrefixIcon;

  @override
  void initState() {
    super.initState();
    _tagsStyler = widget.tagsStyler == null ? TagsStyler() : widget.tagsStyler;
    _textFieldStyler = widget.textFieldStyler == null ? TextFieldStyler() : widget.textFieldStyler;
    _showPrefixIcon = false;

    if (widget.tags != null && widget.tags.isNotEmpty) {
      _showPrefixIcon = true;
      _tagsStringContent = widget.tags;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _scrollController.dispose();
  }

  List<Widget> _getTags() {
    List<Widget> _tags = [];
    for (var i = 0; i < _tagsStringContent.length; i++) {
      String tagText = _tagsStringContent[i];
      Container tag = Container(
        padding: _tagsStyler.tagPadding,
        decoration: _tagsStyler.tagDecoration,
        margin: _tagsStyler.tagMargin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: _tagsStyler.tagTextPadding,
              child: Text(
                tagText,
                style: _tagsStyler.tagTextStyle,
              ),
            ),
            Padding(
              padding: _tagsStyler.tagCancelIconPadding,
              child: GestureDetector(
                onTap: () {
                  if (widget.onDelete != null) widget.onDelete(_tagsStringContent[i]);

                  if (_tagsStringContent.length == 1 && _showPrefixIcon) {
                    setState(() {
                      _tagsStringContent.remove(_tagsStringContent[i]);
                      _showPrefixIcon = false;
                    });
                  } else {
                    setState(() {
                      _tagsStringContent.remove(_tagsStringContent[i]);
                    });
                  }
                },
                child: _tagsStyler.tagCancelIcon,
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
    var _pw = MediaQuery.of(context).size.width;
    _scrollController.animateTo(
      _pw + _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 3),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      autocorrect: false,
      cursorColor: _textFieldStyler.cursorColor,
      style: _textFieldStyler.textStyle,
      decoration: InputDecoration(
        contentPadding: _textFieldStyler.contentPadding,
        isDense: _textFieldStyler.isDense,
        helperText: _textFieldStyler.helperText,
        helperStyle: _textFieldStyler.helperStyle,
        hintText: !_showPrefixIcon ? _textFieldStyler.hintText : null,
        hintStyle: !_showPrefixIcon ? _textFieldStyler.hintStyle : null,
        filled: _textFieldStyler.textFieldFilled,
        fillColor: _textFieldStyler.textFieldFilledColor,
        enabled: _textFieldStyler.textFieldEnabled,
        border: _textFieldStyler.textFieldBorder,
        focusedBorder: _textFieldStyler.textFieldFocusedBorder,
        disabledBorder: _textFieldStyler.textFieldDisabledBorder,
        enabledBorder: _textFieldStyler.textFieldEnabledBorder,
        prefixIcon: _showPrefixIcon
            ? ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.725),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getTags(),
                    ),
                  ),
                ),
              )
            : null,
      ),
      onSubmitted: (value) {
        var val = value.trim().toLowerCase();
        if (value.length > 0) {
          _textEditingController.clear();
          if (!_tagsStringContent.contains(val)) {
            if (widget.onTag != null) widget.onTag(val);

            if (!_showPrefixIcon) {
              setState(() {
                _tagsStringContent.add(val);
                _showPrefixIcon = true;
              });
            } else {
              setState(() {
                _tagsStringContent.add(val);
              });
            }
            this._animateTransition();
          }
        }
      },
      onChanged: (value) {
        var splitedTagsList = value.split(" ");
        var lastLastTag = splitedTagsList[splitedTagsList.length - 2].trim().toLowerCase();

        if (value.contains(" ")) {
          if (lastLastTag.length > 0) {
            _textEditingController.clear();

            if (!_tagsStringContent.contains(lastLastTag)) {
              if (widget.onTag != null) widget.onTag(lastLastTag);

              if (!_showPrefixIcon) {
                setState(() {
                  _tagsStringContent.add(lastLastTag);
                  _showPrefixIcon = true;
                });
              } else {
                setState(() {
                  _tagsStringContent.add(lastLastTag);
                });
              }
              this._animateTransition();
            }
          }
        }
      },
    );
  }
}

import 'package:flutter/material.dart';

import 'models.dart';

class TextFieldTags extends StatefulWidget {
  final TagsStyler tagsStyler;
  final TextFieldStyler textFieldStyler;
  final void Function(String tag) onTag;

  const TextFieldTags({
    Key key,
    this.tagsStyler,
    this.textFieldStyler,
    this.onTag,
  }) : super(key: key);

  @override
  _TextFieldTagsState createState() => _TextFieldTagsState();
}

class _TextFieldTagsState extends State<TextFieldTags> {
  List<String> _tags = [];
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  TagsStyler _tagsStyler;
  TextFieldStyler _textFieldStyler;
  bool _showPrefixIcon;

  @override
  void initState() {
    super.initState();
    _tagsStyler = widget.tagsStyler == null ? TagsStyler() : widget.tagsStyler;
    _textFieldStyler = widget.textFieldStyler == null
        ? TextFieldStyler()
        : widget.textFieldStyler;
    _showPrefixIcon = false;
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _scrollController.dispose();
  }

  List<Widget> _getTags() {
    List<Widget> tags = [];
    for (var i = 0; i < _tags.length; i++) {
      String tagText = _tags[i];
      Container tag = Container(
        padding: _tagsStyler.tagPadding,
        decoration: _tagsStyler.tagDecoration,
        margin: _tagsStyler.tagMargin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tagText,
              style: _tagsStyler.tagTextStyle,
            ),
            GestureDetector(
              onTap: () {
                if (_tags.length <= 1 && _showPrefixIcon == true) {
                  setState(() {
                    _tags.remove(_tags[i]);
                    _showPrefixIcon = false;
                  });
                } else {
                  setState(() {
                    _tags.remove(_tags[i]);
                  });
                }
              },
              child: _tagsStyler.tagCancelIcon,
            ),
          ],
        ),
      );
      tags.add(tag);
    }
    return tags;
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
        hintText: _showPrefixIcon == false ? _textFieldStyler.hintText : null,
        hintStyle: _showPrefixIcon == false ? _textFieldStyler.hintStyle : null,
        filled: _textFieldStyler.textFieldFilled,
        fillColor: _textFieldStyler.textFieldFilledColor,
        enabled: _textFieldStyler.textFieldEnabled,
        border: _textFieldStyler.textFieldBorder,
        focusedBorder: _textFieldStyler.textFieldFocusedBorder,
        disabledBorder: _textFieldStyler.textFieldDisabledBorder,
        enabledBorder: _textFieldStyler.textFieldEnabledBorder,
        prefixIcon: _showPrefixIcon == true
            ? ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.725),
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
          if (!_tags.contains(val)) {
            if (_showPrefixIcon == false) {
              widget.onTag(val);
              setState(() {
                _tags.add(val);
                _showPrefixIcon = true;
              });
            } else {
              widget.onTag(val);
              setState(() {
                _tags.add(val);
              });
            }
            this._animateTransition();
          }
        }
      },
      onChanged: (value) {
        var splitedTagsList = value.split(" ");
        var lastLastTag =
            splitedTagsList[splitedTagsList.length - 2].trim().toLowerCase();

        if (value.contains(" ")) {
          if (lastLastTag.length > 0) {
            _textEditingController.clear();

            if (!_tags.contains(lastLastTag)) {
              if (_showPrefixIcon == false) {
                widget.onTag(lastLastTag);
                setState(() {
                  _tags.add(lastLastTag);
                  _showPrefixIcon = true;
                });
              } else {
                widget.onTag(lastLastTag);
                setState(() {
                  _tags.add(lastLastTag);
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

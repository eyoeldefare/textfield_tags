import 'package:flutter/material.dart';

import 'models.dart';

class TextFieldTags extends StatefulWidget {
  ///[tagsStyler] must not be [null]
  final TagsStyler tagsStyler;

  ///[textFieldStyler] must not be [null]
  final TextFieldStyler textFieldStyler;

  ///[onTag] must not be [null] and should be implemented
  final void Function(String tag) onTag;

  ///[onDelete] must not be [null]
  final void Function(String tag) onDelete;

  ///[initialTags] are optional initial tags you can enter
  final List<String> initialTags;

  const TextFieldTags({
    Key key,
    @required this.tagsStyler,
    @required this.textFieldStyler,
    @required this.onTag,
    @required this.onDelete,
    this.initialTags,
  })  : assert(tagsStyler != null && textFieldStyler != null,
            'tagsStyler and textFieldStyler should not be null'),
        assert(onDelete != null && onTag != null,
            'onDelete and onTag should not be null'),
        super(key: key);

  @override
  _TextFieldTagsState createState() => _TextFieldTagsState();
}

class _TextFieldTagsState extends State<TextFieldTags> {
  List<String> _tagsStringContent = [];
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool _showPrefixIcon = false;
  double _deviceWidth;

  @override
  void initState() {
    super.initState();
    if (widget.initialTags != null && widget.initialTags.isNotEmpty) {
      _showPrefixIcon = true;
      _tagsStringContent = widget.initialTags;
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
    _textEditingController.dispose();
    _scrollController.dispose();
  }

  List<Widget> get _getTags {
    List<Widget> _tags = [];
    for (var i = 0; i < _tagsStringContent.length; i++) {
      String tagText = widget.tagsStyler.showHashtag ?  "#${_tagsStringContent[i]}" : _tagsStringContent[i];
      var tag = Container(
        padding: widget.tagsStyler.tagPadding,
        decoration: widget.tagsStyler.tagDecoration,
        margin: widget.tagsStyler.tagMargin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: widget.tagsStyler.tagTextPadding,
              child: Text(
                tagText,
                style: widget.tagsStyler.tagTextStyle,
              ),
            ),
            Padding(
              padding: widget.tagsStyler.tagCancelIconPadding,
              child: GestureDetector(
                onTap: () {
                  if (widget.onDelete != null)
                    widget.onDelete(_tagsStringContent[i]);

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
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
        contentPadding: widget.textFieldStyler.contentPadding,
        isDense: widget.textFieldStyler.isDense,
        helperText: widget.textFieldStyler.helperText,
        helperStyle: widget.textFieldStyler.helperStyle,
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
                constraints: BoxConstraints(maxWidth: _deviceWidth * 0.725),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
        var val = value.trim().toLowerCase();
        if (value.length > 0) {
          _textEditingController.clear();
          if (!_tagsStringContent.contains(val)) {
            widget.onTag(val);
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
        var lastLastTag =
            splitedTagsList[splitedTagsList.length - 2].trim().toLowerCase();

        if (value.contains(" ")) {
          if (lastLastTag.length > 0) {
            _textEditingController.clear();

            if (!_tagsStringContent.contains(lastLastTag)) {
              widget.onTag(lastLastTag);

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

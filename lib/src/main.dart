import 'package:flutter/material.dart';
import 'models.dart';

typedef Validator = String? Function(String tag);

enum LetterCase { none, small, capital }

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

  ///Enter optional String separators to split tags. Default is [","," "]
  final List<String>? textSeparators;

  ///Change the letter case of the text entered by user. Default is set to small letter[LetterCase.small]
  final LetterCase letterCase;

  ///Use this to add more custumization and control over the tags and textfield
  final TextFieldTagsController? textFieldTagsController;

  const TextFieldTags({
    Key? key,
    this.tagsDistanceFromBorderEnd = 0.725,
    this.scrollableTagsPadding = const EdgeInsets.symmetric(horizontal: 4.0),
    this.scrollableTagsMargin,
    this.validator,
    this.initialTags = const [],
    this.textSeparators = const [' ', ','],
    this.letterCase = LetterCase.small,
    this.textFieldTagsController,
    required this.tagsStyler,
    required this.textFieldStyler,
    required this.onTag,
    required this.onDelete,
  }) : super(key: key);

  @override
  _TextFieldTagsState createState() => _TextFieldTagsState();
}

class _TextFieldTagsState extends State<TextFieldTags> {
  late Set<String>? _tagsStringContents;
  late TextFieldTagsController? _tagController;
  late ScrollController? _scrollController;
  late double? _deviceWidth;
  late Map<String, dynamic>? _tagState;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tagController =
        widget.textFieldTagsController ?? TextFieldTagsController();
    _tagController!.init(widget.initialTags!, widget.initialTags!.isNotEmpty);

    //init class props
    _tagsStringContents = _tagController!.getSetTags;
    _tagState = _tagController!.getTagStates;

    //listen for changes
    _tagController!.addListener(() {
      setState(() {
        _tagsStringContents = _tagController!.getSetTags;
        _tagState!['show_validator'] = _tagController!.showValidator;
        _tagState!['show_prefix_icon'] = _tagController!.showPrefixIcon;
        _tagState!['validator_message'] =
            _tagController!.getError['error_text'];
        _tagState!['validator_style'] = _tagController!.getError['error_style'];
      });
    });
    _animateTransition();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _deviceWidth = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController!.dispose();
    _tagController!.dispose();
    _tagsStringContents = null;
    _scrollController = null;
    _deviceWidth = null;
    _tagController = null;
  }

  List<Widget> get _getTags {
    List<Widget> _tags = [];
    for (var i = 0; i < _tagsStringContents!.length; i++) {
      final String stringContent = _tagsStringContents!.elementAt(i);
      final String stringContentWithHash =
          widget.tagsStyler.showHashtag ? '#$stringContent' : stringContent;
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
                  if (_tagsStringContents!.length <= 1 &&
                      _tagState!['show_prefix_icon']) {
                    _tagController!.removeTag = stringContent;
                    _tagController!.setPrefixIcon = false;
                  } else {
                    _tagController!.removeTag = stringContent;
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
      maxLength: widget.textFieldStyler.maxLength,
      keyboardType: widget.textFieldStyler.textInputType,
      readOnly: widget.textFieldStyler.readOnly,
      controller: TextFieldTagsController.getTextEditingController,
      autocorrect: false,
      cursorColor: widget.textFieldStyler.cursorColor,
      style: widget.textFieldStyler.textStyle,
      decoration: InputDecoration(
        icon: widget.textFieldStyler.icon,
        contentPadding: widget.textFieldStyler.contentPadding,
        isDense: widget.textFieldStyler.isDense,
        helperText: _tagState!['show_validator']
            ? _tagState!['validator_message']
            : widget.textFieldStyler.helperText,
        helperStyle: _tagState!['show_validator']
            ? _tagState!['validator_style']
            : widget.textFieldStyler.helperStyle,
        hintText: !_tagState!['show_prefix_icon']
            ? widget.textFieldStyler.hintText
            : null,
        hintStyle: !_tagState!['show_prefix_icon']
            ? widget.textFieldStyler.hintStyle
            : null,
        filled: widget.textFieldStyler.textFieldFilled,
        fillColor: widget.textFieldStyler.textFieldFilledColor,
        enabled: widget.textFieldStyler.textFieldEnabled,
        border: widget.textFieldStyler.textFieldBorder,
        focusedBorder: widget.textFieldStyler.textFieldFocusedBorder,
        disabledBorder: widget.textFieldStyler.textFieldDisabledBorder,
        enabledBorder: widget.textFieldStyler.textFieldEnabledBorder,
        prefixIcon: _tagState!['show_prefix_icon']
            ? ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: _deviceWidth! * widget.tagsDistanceFromBorderEnd,
                ),
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
        if (_tagState!['show_validator'] == false) {
          final val = widget.letterCase == LetterCase.small
              ? value.trim().toLowerCase()
              : widget.letterCase == LetterCase.capital
                  ? value.trim().toUpperCase()
                  : value.trim();
          TextFieldTagsController.getTextEditingController.clear();
          if (widget.validator == null || widget.validator!(val) == null) {
            widget.onTag(val);
            if (!_tagState!['show_prefix_icon']) {
              _tagController!.addTag = val;
              _tagController!.setPrefixIcon = true;
            } else {
              _tagController!.addTag = val;
            }
            _animateTransition();
          } else {
            _tagController!.setShowValidator = true;
            _tagController!.showError(widget.validator!(val)!);
          }
        }
      },
      onChanged: (value) {
        if (_tagState!['show_validator'] == false) {
          final containedSeparator = widget.textSeparators!
              .cast<String?>()
              .firstWhere(
                  (element) =>
                      value.contains(element!) && value.indexOf(element) != 0,
                  orElse: () => null);
          if (containedSeparator != null) {
            final splits = value.split(containedSeparator);
            final int indexer =
                splits.length > 1 ? splits.length - 2 : splits.length - 1;

            final lastLastTag = widget.letterCase == LetterCase.small
                ? splits.elementAt(indexer).trim().toLowerCase()
                : widget.letterCase == LetterCase.capital
                    ? splits.elementAt(indexer).trim().toUpperCase()
                    : splits.elementAt(indexer).trim();

            TextFieldTagsController.getTextEditingController.clear();

            if (widget.validator == null ||
                widget.validator!(lastLastTag) == null) {
              widget.onTag(lastLastTag);
              if (!_tagState!['show_prefix_icon']) {
                _tagController!.addTag = lastLastTag;
                _tagController!.setPrefixIcon = true;
              } else {
                _tagController!.addTag = lastLastTag;
              }
              _animateTransition();
            } else {
              _tagController!.setShowValidator = true;
              _tagController!.showError(widget.validator!(lastLastTag)!);
            }
          }
        } else {
          _tagController!.setShowValidator = false;
        }
      },
    );
  }
}

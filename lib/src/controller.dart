import 'package:flutter/material.dart';

typedef Validator<T> = String? Function(T tag);
typedef TextFieldTagsBuilder<T> = Widget Function(
  BuildContext context,
  TextFieldTagValues<T> textFieldTagValues,
);

enum LetterCase { normal, small, capital }

class ObjIder<O> {
  final O object;
  final bool origin;
  const ObjIder(this.object, this.origin);
}

class TextFieldTagValues<T> {
  final void Function(T tag) onChanged;
  final void Function(T tag) onSubmitted;
  final void Function(T tag) onTagDelete;
  final ScrollController tagScrollController;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  List<T> tags;
  String? error;

  TextFieldTagValues({
    required this.textEditingController,
    required this.focusNode,
    required this.error,
    required this.onChanged,
    required this.onSubmitted,
    required this.onTagDelete,
    required this.tags,
    required this.tagScrollController,
  });
}

abstract class TextfieldTagsNotifier<T> extends ChangeNotifier {
  late ObjIder<ScrollController>? _scrollController;
  late ObjIder<FocusNode>? _focusNode;
  late ObjIder<TextEditingController>? _textEditingController;

  late LetterCase? _letterCase;
  late Set<String>? _textSeparators;
  late List<T>? _tags;
  late Validator<T>? _validator;

  TextfieldTagsNotifier({
    List<T>? initialTags,
    Set<String>? textSeparators,
    LetterCase? letterCase,
    Validator<T>? validator,
    ObjIder<FocusNode>? focusNode,
    ObjIder<TextEditingController>? textEditingController,
    ObjIder<ScrollController>? scrollController,
  }) {
    _tags = initialTags;
    _textSeparators = textSeparators;
    _letterCase = letterCase;
    _validator = validator;

    _scrollController = scrollController;
    _textEditingController = textEditingController;
    _focusNode = focusNode;
  }

  bool? addTag(T tag) {
    if (_tags != null) {
      _tags!.add(tag);
      return true;
    }
    return null;
  }

  bool? removeTag(T tag) {
    if (_tags != null) {
      bool removed = _tags!.remove(tag);
      return removed;
    }
    return null;
  }

  bool? updateTag(T tag) {
    if (_tags != null) {
      int index = _tags!.indexOf(tag);
      _tags![index] = tag;
      return true;
    }
    return null;
  }

  bool? clearTags() {
    if (_tags != null) {
      _tags!.clear();
      return true;
    }
    return null;
  }

  void onChanged(T value);
  void onSubmitted(T value);
  void onTagDelete(T tag);

  @override
  void dispose() {
    super.dispose();
    if (_textEditingController != null &&
        _textEditingController!.origin == true) {
      _textEditingController!.object.dispose();
    }
    if (_focusNode != null && _focusNode!.origin == true) {
      _focusNode!.object.dispose();
    }
    if (_scrollController != null && _scrollController!.origin == true) {
      _scrollController!.object.dispose();
    }
  }
}

class TextfieldTagsController<T> extends TextfieldTagsNotifier<T> {
  late int _tagScrollAnimationSpeedInMs;
  late String? _error;
  static Function throwTypeError() => throw Exception(
      'This controller only supports String tags for tags. Feel free to extend class for other types for any reason');

  TextfieldTagsController()
      : _tagScrollAnimationSpeedInMs = 300,
        _error = null,
        super();

  TextfieldTagsController.icr(
    List<T>? initialTags,
    List<String>? textSeparators,
    Validator<T>? validator,
    LetterCase? letterCase,
    FocusNode? focusNode,
    TextEditingController? textEditingController,
    ScrollController? scrollController,
  )   : _tagScrollAnimationSpeedInMs = 300,
        super(
          initialTags: initialTags != null ? initialTags.toList() : [],
          textSeparators: textSeparators != null ? textSeparators.toSet() : {},
          letterCase: letterCase ?? LetterCase.normal,
          validator: validator,
          focusNode: focusNode != null
              ? ObjIder<FocusNode>(focusNode, false)
              : ObjIder<FocusNode>(FocusNode(), true),
          textEditingController: textEditingController != null
              ? ObjIder<TextEditingController>(textEditingController, false)
              : ObjIder<TextEditingController>(TextEditingController(), true),
          scrollController: scrollController != null
              ? ObjIder<ScrollController>(scrollController, false)
              : ObjIder<ScrollController>(ScrollController(), true),
        );

  List<T>? get getTags => _tags?.toList();
  String? get getError => _error;
  ScrollController? get getScrollController => _scrollController?.object;
  FocusNode? get getFocusNode => _focusNode?.object;
  TextEditingController? get getTextEditingController =>
      _textEditingController?.object;
  int get tagScrollAnimationSpeedInMs => _tagScrollAnimationSpeedInMs;

  set setTagScrollAnimationSpeedInMs(int tsas) {
    _tagScrollAnimationSpeedInMs = tsas;
  }

  void scrollTags() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController != null && _scrollController!.object.hasClients) {
        _scrollController!.object.animateTo(
          _scrollController!.object.position.maxScrollExtent,
          duration: Duration(milliseconds: tagScrollAnimationSpeedInMs),
          curve: Curves.linear,
        );
      }
    });
  }

  void registerController(
    List<T>? initialTags,
    List<String>? textSeparators,
    LetterCase? letterCase,
    Validator<T>? validator,
    FocusNode? focusNode,
    TextEditingController? textEditingController,
    ScrollController? scrollController,
  ) {
    assert(
      (_tags == null ||
          _textSeparators == null ||
          _letterCase == null ||
          _validator == null),
      'You\'ve already registered a tag controller',
    );
    _tags = initialTags != null ? initialTags.toList() : [];
    _textSeparators = textSeparators != null ? textSeparators.toSet() : {};
    _letterCase = letterCase ?? LetterCase.normal;
    _validator = validator;
    _focusNode = focusNode != null
        ? ObjIder<FocusNode>(focusNode, false)
        : ObjIder<FocusNode>(FocusNode(), true);
    _textEditingController = textEditingController != null
        ? ObjIder<TextEditingController>(textEditingController, false)
        : ObjIder<TextEditingController>(TextEditingController(), true);
    _scrollController = scrollController != null
        ? ObjIder<ScrollController>(scrollController, false)
        : ObjIder<ScrollController>(ScrollController(), true);
  }

  void _onTagOperation(T tag) {
    if (tag is String) {
      if (tag.isNotEmpty) {
        _textEditingController?.object.clear();
        _error = _validator != null ? _validator!(tag) : null;
        if (_error == null) {
          bool? added = super.addTag(tag);
          if (added == true) {
            scrollTags();
          }
        }
        notifyListeners();
      }
    } else {
      throwTypeError();
    }
  }

  @override
  bool? clearTags() {
    bool? clear = super.clearTags();
    if (clear == true) {
      _error = null;
      _textEditingController?.object.clear();
      _focusNode?.object.requestFocus();
      notifyListeners();
      return clear;
    }
    return null;
  }

  @override
  void onChanged(T value) {
    if (value is String) {
      final ts = _textSeparators;
      final lc = _letterCase;
      final separator = ts?.cast<String?>().firstWhere(
          (element) => value.contains(element!) && value.indexOf(element) != 0,
          orElse: () => null);
      if (separator != null) {
        final splits = value.split(separator);
        final indexer =
            splits.length > 1 ? splits.length - 2 : splits.length - 1;
        final val = lc == LetterCase.small
            ? splits.elementAt(indexer).trim().toLowerCase()
            : lc == LetterCase.capital
                ? splits.elementAt(indexer).trim().toUpperCase()
                : splits.elementAt(indexer).trim();
        _onTagOperation(val as T);
      }
    } else {
      throwTypeError();
    }
  }

  @override
  void onSubmitted(T value) {
    if (value is String) {
      final lc = _letterCase;
      final val = lc == LetterCase.small
          ? value.trim().toLowerCase()
          : lc == LetterCase.capital
              ? value.trim().toUpperCase()
              : value.trim();
      _onTagOperation(val as T);
    } else {
      throwTypeError();
    }
  }

  @override
  void onTagDelete(T tag) {
    if (tag is String) {
      bool? removed = removeTag(tag);
      if (removed == true) {
        _error = null;
        notifyListeners();
      }
    } else {
      throwTypeError();
    }
  }
}

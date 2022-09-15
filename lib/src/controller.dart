import 'package:flutter/material.dart';

typedef Validator = String? Function(String tag);
typedef TagsBuilder<T> = T Function(
  BuildContext context,
  ScrollController sc,
  List<String> tags,
  void Function(String tag) onDeleteTag,
);
typedef InputFieldBuilder<T> = TagsBuilder<T> Function(
  BuildContext context,
  TextEditingController tec,
  FocusNode fn,
  String? error,
  void Function(String value)? onChanged,
  void Function(String value)? onSubmitted,
);

enum LetterCase { normal, small, capital }

abstract class TextfieldTagsNotifier extends ChangeNotifier {
  TextfieldTagsNotifier();

  final scrollController = ScrollController();

  late TextEditingController? textEditingController;
  late FocusNode? focusNode;

  late Set<String>? _textSeparators;
  late List<String>? _tags;
  List<String>? get getTags => _tags?.toList();

  void initS(
    List<String>? initialTags,
    TextEditingController? tec,
    FocusNode? fn,
    List<String>? textSeparators,
  ) {
    _textSeparators = (textSeparators?.toSet() ?? {});
    textEditingController = tec ?? TextEditingController();
    focusNode = fn ?? FocusNode();
    _tags = initialTags?.toList() ?? [];
  }

  set addTag(String tag) {
    _tags!.add(tag);
  }

  set removeTag(String tag) {
    _tags!.remove(tag);
  }

  onChanged(String value);
  onSubmitted(String value);
  onTagDelete(String tag);
}

class TextfieldTagsController extends TextfieldTagsNotifier {
  LetterCase? _letterCase;
  Validator? _validator;
  String? _error;

  TextfieldTagsController();

  void init(
    Validator? validator,
    LetterCase? letterCase,
    List<String>? initialTags,
    TextEditingController? tec,
    FocusNode? fn,
    List<String>? textSeparators,
  ) {
    super.initS(initialTags, tec, fn, textSeparators);
    _letterCase = letterCase ?? LetterCase.normal;
    _validator = validator;
  }

  bool get hasError => _error != null && _error!.isNotEmpty;
  bool get hasTags => _tags != null && _tags!.isNotEmpty;
  String? get getError => _error;

  void scrollTags({
    bool forward = true,
    int speedInMilliseconds = 300,
    double? distance,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        if (distance != null) {
          scrollController.animateTo(
            distance,
            duration: Duration(milliseconds: speedInMilliseconds),
            curve: Curves.linear,
          );
        } else {
          if (forward) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: speedInMilliseconds),
              curve: Curves.linear,
            );
          } else {
            scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: speedInMilliseconds),
              curve: Curves.linear,
            );
          }
        }
      }
    });
  }

  void _onTagOperation(String tag) {
    if (tag.isNotEmpty) {
      textEditingController!.clear();
      _error = _validator != null ? _validator!(tag) : null;
      if (!hasError) {
        super.addTag = tag;
        scrollTags();
      }
      notifyListeners();
    }
  }

  @override
  void onChanged(String value) {
    final ts = _textSeparators!;
    final lc = _letterCase!;
    final separator = ts.cast<String?>().firstWhere(
        (element) => value.contains(element!) && value.indexOf(element) != 0,
        orElse: () => null);
    if (separator != null) {
      final splits = value.split(separator);
      final indexer = splits.length > 1 ? splits.length - 2 : splits.length - 1;
      final val = lc == LetterCase.small
          ? splits.elementAt(indexer).trim().toLowerCase()
          : lc == LetterCase.capital
              ? splits.elementAt(indexer).trim().toUpperCase()
              : splits.elementAt(indexer).trim();
      _onTagOperation(val);
    }
  }

  @override
  void onSubmitted(String value) {
    final lc = _letterCase!;
    final val = lc == LetterCase.small
        ? value.trim().toLowerCase()
        : lc == LetterCase.capital
            ? value.trim().toUpperCase()
            : value.trim();
    _onTagOperation(val);
  }

  @override
  set addTag(String value) {
    onSubmitted(value);
  }

  @override
  void onTagDelete(String tag) {
    removeTag = tag;
    notifyListeners();
  }

  set setError(String error) {
    _error = error;
    notifyListeners();
  }

  void clearTags() {
    _error = null;
    _tags!.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController!.dispose();
    focusNode!.dispose();
    scrollController.dispose();
  }
}

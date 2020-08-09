import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:text_editor/src/web/textarea_widget.dart';

class TextEditor extends StatefulWidget {
  final bool autofocus;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  TextEditor({
    Key key,
    this.autofocus = false,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  String _styleStr;
  final _key = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _styleStr = _getStyle(context);
    widget.controller?.addListener(_copyText);
  }

  void _copyText() {
    final state = _key.currentState as TextAreaWidgetState;
    state.text = widget.controller.text;
  }

  String _getStyle(BuildContext context) {
    final style = Theme.of(context).textTheme.subtitle1;
    final fontFamily =
        style.fontFamily == '.SF UI Text' ? '-apple-system, BlinkMacSystemFont, Roboto, sans-serif' : style.fontFamily;
    final fontSize = style.fontSize;
    final fontWeight = int.parse(style.fontWeight.toString().split('w').last);
    // final color = '#${theme.color.value.toRadixString(16)}';
    final styleStr =
        'border: 0; outline: none; resize: none; font-family: $fontFamily; font-size: $fontSize; font-weight: $fontWeight;';
    return styleStr;
  }

  @override
  Widget build(BuildContext context) => TextAreaWidget(
        key: _key,
        initialValue: widget.controller?.text,
        autofocus: widget.autofocus,
        style: _styleStr,
        onChanged: (value) {
          widget.controller?.text = value;
          widget.onChanged?.call(value);
        },
      );
}

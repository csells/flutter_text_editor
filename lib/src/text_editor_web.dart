import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:text_editor/src/web/textarea_widget.dart';

class TextEditor extends StatelessWidget {
  final bool autofocus;
  final TextEditingController _controller;
  TextEditor({
    Key key,
    this.autofocus,
    @required TextEditingController controller,
  })  : _controller = controller,
        assert(controller != null),
        super(key: key) {
    controller.addListener(_copyText);
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
    print('style: $styleStr');
    return styleStr;
  }

  @override
  Widget build(BuildContext context) => TextAreaWidget(
        initialValue: _controller.text,
        autofocus: autofocus,
        style: _getStyle(context),
        onChanged: (value) => _controller.text = value,
      );

  void _copyText() {}
}

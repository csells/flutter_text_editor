import 'package:flutter/material.dart';

class TextEditor extends StatelessWidget {
  final bool autofocus;
  final String hintText;
  final int maxlines;
  final TextEditingController _controller;
  final ValueChanged<String> onChanged;

  const TextEditor({
    Key key,
    this.autofocus = false,
    this.hintText = '',
    this.maxlines,
    @required TextEditingController controller,
    this.onChanged,
  })  : _controller = controller,
        assert(controller != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => TextField(
        maxLines: maxlines,
        autofocus: autofocus,
        controller: _controller,
        decoration: InputDecoration(border: InputBorder.none, hintText: hintText),
        onChanged: onChanged,
      );
}
